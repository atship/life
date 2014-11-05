#运行一个程序，并传递相应的参数
gdb myProgram
run --parameter test

#设置断点
b(reak) /home/test/work/test/src/test.cpp:17
或者
b(reak) 12

#列出断点
i(nfo) b

#删除断点
d 0/1/2...

#查看变量的值
p(rint)

#查看变量的类型
pt(ype)

#查看函数调用顺序（栈帧）
b(ack)t(race)

#跳到栈帧中的某一帧
f(rame)
