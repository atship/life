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
