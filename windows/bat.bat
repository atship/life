::判断目标是否是目录
if exist %target%\nul (
	echo 'is a folder'
) else (
	echo 'not a folder'
)

::获取当前脚本所有的目录
set root=%~dp0

::for获取整行，禁止被空格打断
for /f "delims=" %%i in (file.txt) do (
	echo %%i
)

::字符串替换，下面将文件file.txt中的_HI_替换为_HELLO_
::有一个坑：echo 后面不能输出空格和TAB，如果后面有空格或者TAB，则将输出 ECHO 处于打开/关闭状态
setlocal enabledelayedexpansion
for /f "delims=" %%i in (file.txt) do (
	set line=%%i
	set line=!line:_HI_=_HELLO_!
	echo !line!
)

::echo 输出多行文件 
@echo first line ^

second line ^

third line ^

> file.txt

::for步进循环
for /L %%i in (1, 1, 10) do (
	echo %%i
)

::用于统计数量的循环
setlocal enabledelayedexpansion
set count=1
for /f "delims=" %%i in ('dir /b') do (
	echo '第!count!个文件: %%i'
	set /a count=!count!+1
)