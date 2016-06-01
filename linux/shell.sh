1, 第一行要指定为#!/bin/bash，因为ubuntu之类的系统会把/bin/dash链接到/bin/sh，导致脚本失效，因为这两个环境(bash, dash)语法不同
可以参照 http://www.igigo.net/post/archives/169

在一个字符串中使用变量的时候，需要这样：
	i_am_well${var}_done

2, heredoc
cat > file <<doc
	This is your content
	this is second line content
	...
doc

3, for
	1) fileList="file1 file2 file3"
	   for file in $fileList
	   do
	   done

	2) for file in file1 file2 file3
	   do
	   done
       
    3) for i in $(seq 100); do echo $i; done # seq是外部命令
       for i in {0..100}; do echo $i; done

4, read line
	while read line
	do 
	done < file

5, 字符串截取
	str="wa ha hawo"
	${str:0:4} //wa h
	${str:0:7} //wa ha h
	${str:0-3} //awo
	${#str} //字符串长度8

6, 字符串拼接
    str="wa ha"
    str=$str" ha"
    echo $str // wa ha ha
    
7, 字符串替换(数据量大的时候特别慢)
    str="wa ha ha"
    ${str/ha/haha} //wa haha ha
    ${str//ha/haha} //wa haha haha

8, 要替换文件中的字符串，并且要原样输出的话，建议一行一行读取，因为当文件比较大的时候，一次性读取进来再进行替换操作，会很慢
   要原样输出只需要加上“”即可
    1, 整体读取和替换（速度慢）
        content=$(<fileName)
        after=${content//_REPLACE_ME_/_REPLACING_}
        echo “$after” > newFileName
    2, 按行读取和替换
        while read line
        do
            after=$(line//_REPLACE_ME_/_REPLACING_}
            echo “$after” >> newFileName
        done < fileName

9, bc 显示其它进制
    obase=2
    obase=8
    obase=10
    obase=16

    保留2位小数点
    scale=2

10, if 条件判断
[ ! -d FILE ] 如果 FILE 不是目录则为真
[ -a FILE ]  如果 FILE 存在则为真。
[ -b FILE ]  如果 FILE 存在且是一个块特殊文件则为真。
[ -c FILE ]  如果 FILE 存在且是一个字特殊文件则为真。
[ -d FILE ]  如果 FILE 存在且是一个目录则为真。
[ -e FILE ]  如果 FILE 存在则为真。
[ -f FILE ]  如果 FILE 存在且是一个普通文件则为真。
[ -g FILE ]  如果 FILE 存在且已经设置了SGID则为真。
[ -h FILE ]  如果 FILE 存在且是一个符号连接则为真。
[ -k FILE ]  如果 FILE 存在且已经设置了粘制位则为真。
[ -p FILE ]  如果 FILE 存在且是一个名字管道(F如果O)则为真。
[ -r FILE ]  如果 FILE 存在且是可读的则为真。
[ -s FILE ]  如果 FILE 存在且大小不为0则为真。
[ -t FD ]  如果文件描述符 FD 打开且指向一个终端则为真。
[ -u FILE ]  如果 FILE 存在且设置了SUID (set user ID)则为真。
[ -w FILE ]  如果 FILE 如果 FILE 存在且是可写的则为真。
[ -x FILE ]  如果 FILE 存在且是可执行的则为真。
[ -O FILE ]  如果 FILE 存在且属有效用户ID则为真。
[ -G FILE ]  如果 FILE 存在且属有效用户组则为真。
[ -L FILE ]  如果 FILE 存在且是一个符号连接则为真。
[ -N FILE ]  如果 FILE 存在 and has been mod如果ied since it was last read则为真。
[ -S FILE ]  如果 FILE 存在且是一个套接字则为真。
[ FILE1 -nt FILE2 ]  如果 FILE1 has been changed more recently than FILE2, or 如果 FILE1 exists and FILE2 does not则为真。
[ FILE1 -ot FILE2 ]  如果 FILE1 比 FILE2 要老, 或者 FILE2 存在且 FILE1 不存在则为真。
[ FILE1 -ef FILE2 ]  如果 FILE1 和 FILE2 指向相同的设备和节点号则为真。
[ -o OPTIONNAME ]  如果 shell选项 “OPTIONNAME” 开启则为真。
[ -z STRING ]  “STRING” 的长度为零则为真。
[ -n STRING ] or [ STRING ]  “STRING” 的长度为非零 non-zero则为真。
[ STRING1 == STRING2 ]  如果2个字符串相同。 “=” may be used instead of “==” for strict POSIX compliance则为真。
[ STRING1 != STRING2 ]  如果字符串不相等则为真。
[ STRING1 < STRING2 ]  如果 “STRING1” sorts before “STRING2” lexicographically in the current locale则为真。
[ STRING1 > STRING2 ]  如果 “STRING1” sorts after “STRING2” lexicographically in the current locale则为真。
[ ARG1 OP ARG2 ] “OP” is one of -eq, -ne, -lt, -le, -gt or -ge. These arithmetic binary operators return true if “ARG1” is equal to, not equal to, less than, less than or equal to, greater than, or greater than or equal to “ARG2”, respectively. “ARG1” and “ARG2” are integers.
