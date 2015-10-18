::判断目标是否是目录
if exist %target%\nul (
	echo 'is a folder'
) else (
	echo 'not a folder'
)

::获取当前脚本所在的目录
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

::延迟绑定的原理，是因为MS读取完整的语句块并且直接将变量替换成值导致了需要延迟绑定，例如
set count=10
for /L %%i in (1, 1, 10) do (
	echo %count%
	set /a count=%count%-1
)
echo %count%
::当执行到for循环的时候，将会被解释成这样：
set count=10
for /L %%i in (1, 1, 10) do (
	echo 10
	set /a count=10-1
)
::下一句将会打印9
echo %count%
::因此，除非启用延迟绑定，否则其行为就不是我们所期望的，启用之后看一下会解释成这样
setlocal enabledelayedexpansion
set count=10
for /L %%i in (1, 1, 10) do (
	echo !count!
	set /a count=!count!-1
}

::查询变量是否已定义
if defined count (
	echo yes
) else (
	echo no
)