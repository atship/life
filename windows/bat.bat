::�ж�Ŀ���Ƿ���Ŀ¼
if exist %target%\nul (
	echo 'is a folder'
) else (
	echo 'not a folder'
)

::��ȡ��ǰ�ű����е�Ŀ¼
set root=%~dp0

::for��ȡ���У���ֹ���ո���
for /f "delims=" %%i in (file.txt) do (
	echo %%i
)

::�ַ����滻�����潫�ļ�file.txt�е�_HI_�滻Ϊ_HELLO_
::��һ���ӣ�echo ���治������ո��TAB����������пո����TAB������� ECHO ���ڴ�/�ر�״̬
setlocal enabledelayedexpansion
for /f "delims=" %%i in (file.txt) do (
	set line=%%i
	set line=!line:_HI_=_HELLO_!
	echo !line!
)

::echo ��������ļ� 
@echo first line ^

second line ^

third line ^

> file.txt

::for����ѭ��
for /L %%i in (1, 1, 10) do (
	echo %%i
)

::����ͳ��������ѭ��
setlocal enabledelayedexpansion
set count=1
for /f "delims=" %%i in ('dir /b') do (
	echo '��!count!���ļ�: %%i'
	set /a count=!count!+1
)