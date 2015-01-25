#!/bin/bash
# create project -c prj-path prj-name pkg-name
# update project -u prj-path

#cfont by zuoyang http://hi.baidu.com/test/
function cfont()
{
    while (($#!=0))
    do
        case $1 in
            -b)
                echo -ne " ";
            ;;
            
            -t)
                echo -ne "\t";
            ;;
            
            -n) 
                echo -ne "\n";
            ;;
            
            -black)
                echo -ne "\033[30m";
            ;;
            
            -red)
                echo -ne "\033[31m";
            ;;
            
            -green)
                echo -ne "\033[32m";
            ;;
            
            -yellow)
                echo -ne "\033[33m";
            ;;
            
            -blue)
                echo -ne "\033[34m";
            ;;
            
            -purple)
                echo -ne "\033[35m";
            ;;
            
            -cyan)
                echo -ne "\033[36m";
            ;;
            
            -white|-gray) 
                echo -ne "\033[37m";
            ;;
            
            -reset)
                echo -ne "\033[0m";
            ;;
            
            -h|-help|--help)
                    echo "Usage: cfont -color1 message1 -color2 message2 ...";
                    echo "eg:       cfont -red [ -blue message1 message2 -red ]";
            ;;
            
            *)
                echo -ne "$1"
            ;;
        esac
        shift
    done
}

this_full_path=${0//\\//}
this_file=${this_full_path##*/}


function help()
{
    echo "Usage:"
    echo "$0 -c urho3d_build_tree project-path project-name package-name"
    echo "$0 -u urho3d_build_tree project-path"
    echo -e "\t-c\tcreate project"
    echo -e "\t-u\tupdate project with newer version resources"
    echo 
}

# We still need this.
windows() { [[ -n "$WINDIR" ]]; }

function loop_input()
{
    message=$1
    filter=$2
    while [ true ]
    do
        cfont -cyan "$message" -n -reset
        read input
        $filter $input
        if [ $? == 0 ]; then
            break
        fi
    done
}

function filter_project_name()
{
	if [ "$1" == "" ]; then
		exit
	fi
    project_name=$1
    return 0
}

function filter_package_name()
{
	if [ "$1" == "" ]; then
		exit
	fi
    package_name=$1
    return 0
}

function filter_project_path()
{
	if [ "$1" == "" ]; then
		exit
	fi
	sdk_root="$urho3d_build_tree"
	project_path=$1
    if [ -d $project_path ]; then
		project_path=$(cd $1; pwd)
        if windows; then
            drive=${project_path:1:1}
            project_home=${project_path/\/$drive/$drive:}
        else
            project_home=$project_path
        fi
        cfont -red " Project path $project_path exists\n Do you want to replace the project files with newer version?\n (y/n)" -n -reset
		if [[ "$project_path" == "$sdk_root" ]]; then
			cfont -cyan " The path is Urho3D sdk root, don't do this" -n -reset
			return 1
		else
			read _yes_
			if [[ "$_yes_" == "Y" || "$_yes_" == "y" ]]; then
				echo "yes"
				return 0
			else
				echo "no"
				return 1
			fi
		fi
    else
        return 0
    fi
}

function filter_project_path_4update()
{
    project_path=$1
    if [ -d $project_path ]; then
        return 0
    else
        cfont -red "project path $project_path is not exists" -n -reset
        return 1
    fi
}

create_project_flag=1

function summary_and_confirm()
{
    echo 
    if [ $create_project_flag = 1 ]; then
        cfont -green "Summary:(create project)" -n
        cfont -green "Project name: $project_name" -n
        cfont -green "Project path: $project_path" -n
        cfont -green "Package name: $package_name" -n -reset
    else
        cfont -green "Summary:(update project)" -n
        cfont -green "Project path: $project_path" -n
    fi
    cfont -red "Do you agree with these infos? (Y)" -n -reset
    read _agree_
    if [[ "$_agree_" == "" || "$_agree_" == "Y" || "$_agree_" == "y" ]]; then
        return 0
    else
        return 1
    fi
}

function filter_urho3d_build_tree()
{
	if [ "$1" == "" ]; then
		exit
	fi
	urho3d_build_tree="$(cd $1; pwd)"
    if windows; then
        urho3d_drive=${urho3d_build_tree:1:1}
        urho3d_home=${urho3d_build_tree/\/$urho3d_drive/$urho3d_drive:}
    fi
	if [ ! -d "$urho3d_build_tree/CMake" -o ! -d "$urho3d_build_tree/Source" ]; then
		cfont -red "Invalid Urho3D root folder." -n -reset
		return 1
	else
		return 0
	fi
}

function parse_paramters()
{
    case "$1" in
        "-c")
            filter_urho3d_build_tree $2
            if [ $? != 0 ]; then
                loop_input "Enter Urho3D root folder(enter to exit):" filter_urho3d_build_tree
            fi
            filter_project_path $3
            if [ $? != 0 ]; then
                loop_input "Enter project path:" filter_project_path
            fi
            filter_project_name $4
            filter_package_name $5
        ;;

        "-u")
            filter_urho3d_build_tree $2
            if [ $? != 0 ]; then
                loop_input "Enter Urho3D root folder(enter to exit):" filter_urho3d_build_tree
            fi
            filter_project_path_4update $3
            if [ $? != 0 ]; then
                loop_input "Enter the project path:" filter_project_path_4update
            fi
            create_project_flag=0
        ;;

        *)
            help
            cfont -red "Interactive mode\nCreate project now..." -n -reset
			loop_input "Enter Urho3D root folder(enter to exit):" filter_urho3d_build_tree
            loop_input "Enter project path(enter to exit):" filter_project_path
            loop_input "Enter project name(enter to exit):" filter_project_name
            loop_input "Enter package name(enter to exit):" filter_package_name
        ;;
    esac
}

function make_project_dir()
{
    mkdir -p $project_path
    mkdir -p $project_path/Android/src/org
    mkdir -p $project_path/Android/res/values
    mkdir -p $project_path/Android/res/drawable
	mkdir -p $project_path/bin/CoreData
    mkdir -p $project_path/bin/Data/UI
    mkdir -p $project_path/bin/Data/Textures
	mkdir $project_path/CMake
}

# Cross-platform symlink function. With one parameter, it will check
# whether the parameter is a symlink. With two parameters, it will create
# a symlink to a file or directory, with syntax: link $linkname $target
link() {
    if [[ -z "$2" ]]; then
        # Link-checking mode.
        if windows; then
            fsutil reparsepoint query "$1" > /dev/null
        else
            [[ -h "$1" ]]
        fi
    else
        # Link-creation mode.
        if windows; then
            # Windows needs to be told if it's a directory or not. Infer that.
            # Also: note that we convert `/` to `\`. In this case it's necessary.
            
            if [[ -d "$2" ]]; then
                cmd <<< "mklink /D \"${1//\//\\}\" \"${2//\//\\}\"" > /dev/null
            else
                cmd <<< "mklink \"${1//\//\\}\" \"${2//\//\\}\"" > /dev/null
            fi
        else
            # You know what? I think ln's parameters are backwards.
            ln -s "$2" "$1"
        fi
    fi
}

function copy_resources()
{
	cd $urho3d_build_tree
    if windows; then
        cp cmake_generic.bat $project_path/
        cat > $project_path/cmake_android.bat <<android
@%~dp0\cmake_generic.bat %* -DANDROID=1 -DURHO3D_HOME=$urho3d_home/%1
android
        if [ -n "$VS120COMNTOOLS" ]; then
            vs='-VS=12'
        elif [ -n "$VS110COMNTOOLS" ]; then
            vs='-VS=11'
        elif [ -n "$VS100COMNTOOLS" ]; then
            vs="-VS=10"
        fi
        cat > $project_path/cmake_vs.bat <<vs
mkdir %1\bin
mklink /D %1\bin\Data ..\..\bin\Data
mklink /D %1\bin\CoreData ..\..\bin\CoreData
@%~dp0\cmake_generic.bat %* $vs -DURHO3D_HOME=$urho3d_home/%1
vs
    else
        cp cmake_generic.sh $project_path/
        cat > $project_path/cmake_ios.sh <<ios
\$(dirname \$0)/cmake_macosx.sh \$@ -DIOS=1
ios
        cat > $project_path/cmake_macosx.sh <<mac
\$(dirname \$0)/cmake_generic.sh \$@ -G Xcode -DURHO3D_HOME=$urho3d_build_tree/\$1
mac
        cat > $project_path/cmake_android.sh <<android
\$(dirname \$0)/cmake_generic.sh \$@ -DANDROID=1 -DURHO3D_HOME=$urho3d_build_tree/\$1
android
        cp .bash_helpers.sh $project_path/
    fi
    #cp *.sh *.bat $project_path/
    #rm $project_path/$this_file
	#write_android_bat
    cp bin/CoreData/* $project_path/bin/Data/ -r
    cp bin/Data/PostProcess $project_path/bin/Data/ -r
    cp bin/Data/UI/MessageBox.xml $project_path/bin/Data/UI/
    cp bin/Data/Textures/UrhoIcon.png $project_path/bin/Data/Textures/Icon.png
    cp bin/Data/Textures/UrhoIcon.png $project_path/Android/res/icon.png
    #cp Android $project_path/ -r
    cp Android/src/org $project_path/Android/src/ -r
    link $project_home/Android/assets/ $project_home/bin/
	cp CMake $project_path/ -r
    rename_package_name
}

function rename_package_name()
{
   cat > $project_path/Android/AndroidManifest.xml <<mainifest
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="$package_name"
    android:versionCode="1"
    android:versionName="1.0">
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-feature android:glEsVersion="0x00020000" />
    <uses-sdk android:targetSdkVersion="9" android:minSdkVersion="9" />
    <application android:label="@string/app_name" android:icon="@drawable/icon">
        <activity
            android:name="$project_name"
            android:theme="@android:style/Theme.NoTitleBar.Fullscreen"
            android:configChanges="keyboardHidden|orientation|screenSize|smallestScreenSize"
            android:screenOrientation="portrait">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>
</manifest>
mainifest
if [ $create_project_flag == 1 ]; then
    mkdir -p $project_path/Android/src/${package_name//\./\/}
fi

cat > $project_path/Android/res/values/strings.xml <<string
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="app_name">$project_name</string>
</resources>
string

  cat >$project_path/Android/src/${package_name//\./\/}/$project_name.java <<cls
package $package_name;

import org.libsdl.app.SDLActivity;
public class $project_name extends SDLActivity {}
cls
}

function cmake_lists_txt()
{
    cat > $project_path/CMakeLists.txt <<cmake_list
# Set project name
project ($project_name)
# Set minimum version
cmake_minimum_required (VERSION 2.8.6)
if (COMMAND cmake_policy)
    cmake_policy (SET CMP0003 NEW)
    if (CMAKE_VERSION VERSION_GREATER 2.8.12 OR CMAKE_VERSION VERSION_EQUAL 2.8.12)
        # INTERFACE_LINK_LIBRARIES defines the link interface
        cmake_policy (SET CMP0022 NEW)
    endif ()
    if (CMAKE_VERSION VERSION_GREATER 3.0.0 OR CMAKE_VERSION VERSION_EQUAL 3.0.0)
        # Disallow use of the LOCATION target property - therefore we set to OLD as we still need it
        cmake_policy (SET CMP0026 OLD)
        # MACOSX_RPATH is enabled by default
        cmake_policy (SET CMP0042 NEW)
    endif ()
endif ()
# Set CMake modules search path
set (CMAKE_MODULE_PATH \${CMAKE_SOURCE_DIR}/CMake/Modules)
# Include Urho3D Cmake common module
include (Urho3D-CMake-common)
# Find Urho3D library
find_package (Urho3D REQUIRED)
include_directories (\${URHO3D_INCLUDE_DIRS})
# Define target name
set (TARGET_NAME $project_name)
# Define source files
define_source_files ()
# Setup target with resource copying
setup_main_executable ()
cmake_list
}

function cat_project_source()
{
    cat > $project_path/$project_name.h <<source

#pragma once

#include <Urho3D/Engine/Application.h>

// All Urho3D classes reside in namespace Urho3D
using namespace Urho3D;

class $project_name : public Application
{
    // Enable type information.
    OBJECT($project_name)
    
public:
    /// Construct.
    $project_name(Context* context);

    /// Setup before engine initialization. Modifies the engine parameters.
    virtual void Setup();
    /// Setup after engine initialization.
    virtual void Start();

private:
    /// Subscribe to application-wide logic update events.
    void SubscribeToEvents();
    /// Handle the logic update event.
    void HandleUpdate(StringHash eventType, VariantMap& eventData);
    /// Handle key down event to process key controls common to all samples.
    void HandleKeyDown(StringHash eventType, VariantMap& eventData);
#if !defined(ANDROID) && !defined(IOS)
    /// Set custom window Title & Icon
    void SetWindowTitleAndIcon();
#endif
};
source

    cat > $project_path/$project_name.cpp <<cpp
#include <Urho3D/Urho3D.h>
#include <Urho3D/Core/CoreEvents.h>
#include <Urho3D/Engine/Engine.h>
#include <Urho3D/Input/Input.h>
#include <Urho3D/Core/ProcessUtils.h>
#include <Urho3D/Graphics/Graphics.h>
#include <Urho3D/Resource/ResourceCache.h>

#include "$project_name.h"

// Expands to this example's entry-point
DEFINE_APPLICATION_MAIN($project_name)

$project_name::$project_name(Context* context) :
    Application(context)
{
}

void $project_name::Setup()
{
#if !defined(ANDROID) && !defined(IOS)
    // Modify engine startup parameters
    engineParameters_["WindowTitle"] = GetTypeName();
    engineParameters_["LogName"]     = GetTypeName() + ".log";
	engineParameters_["WindowWidth"] = 1024;
	engineParameters_["WindowHeight"] = 600;
    engineParameters_["FullScreen"]  = false;
    engineParameters_["Headless"]    = false;
#endif
}

void $project_name::Start()
{
    //TODO start your project logic here
#if !defined(ANDROID) && !defined(IOS)
    SetWindowTitleAndIcon();
    GetSubsystem<Input>()->SetMouseVisible(true);
#endif

    SubscribeToEvents();    
}

void $project_name::SubscribeToEvents()
{
    // Subscribe key down event
    SubscribeToEvent(E_KEYDOWN, HANDLER($project_name, HandleKeyDown));

    // Subscribe HandleUpdate() function for processing update events
    SubscribeToEvent(E_UPDATE, HANDLER($project_name, HandleUpdate));
}

void $project_name::HandleUpdate(StringHash eventType, VariantMap& eventData)
{
    //TODO Do nothing for now, could be extended to eg. animate the display
}

#if !defined(ANDROID) && !defined(IOS)
void $project_name::SetWindowTitleAndIcon()
{
    ResourceCache* cache = GetSubsystem<ResourceCache>();
    Graphics* graphics = GetSubsystem<Graphics>();
    Image* icon = cache->GetResource<Image>("Textures/Icon.png");
    graphics->SetWindowIcon(icon);
    graphics->SetWindowTitle("$project_name");
}
#endif

void $project_name::HandleKeyDown(StringHash eventType, VariantMap& eventData)
{
    using namespace KeyDown;

    int key = eventData[P_KEY].GetInt();

    switch(key)
    {
    case KEY_ESC:
        //exit when ESC is pressed
        engine_->Exit();
        break;
        
    default:
        break;
    }
}
cpp
}

parse_paramters $*
if [ ! -d $project_path ]; then
    mkdir $project_path
    _create_dir_=1
fi
project_path=$(cd $project_path; pwd)
summary_and_confirm

if [ $? != 0 ]; then
    if [ ! -z $_create_dir_ ]; then
        rmdir $project_path
    fi
    exit
fi

if [ $create_project_flag == 1 ]; then
    make_project_dir
    copy_resources
    cmake_lists_txt
    cat_project_source
else
    make_project_dir
    copy_resources
fi
