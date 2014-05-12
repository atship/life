#（可选）先查看是否已经安装了相应的库文件
$ locate libglut.so
$ locate libGLU.so
$ locate libGL.so

#安装相应的开发头文件
$ sudo yum install mesa-libGL-devel mesa-libGLU-devel freeglut-devel -y

#（可选）查看安装之后头文件所在路径
$ rpm -ql freeglut-devel

#开始工作
$ vi test.cpp
输入以下内容：
#include <GL/glut.h>
void display(){
    glClear(GL_COLOR_BUFFER_BIT);
    glBegin(GL_POLYGON);
    glVertex2f(-0.5,-0.5);
    glVertex2f(-0.5,0.5);
    glVertex2f(0.5,0.5);
    glVertex2f(0.5,-0.5);
    glEnd();
    glFlush();
}
int main(int argc,char *argv[]){
    glutInit(&argc,argv);
    glutCreateWindow("Simple");
    glutDisplayFunc(display);
    glutMainLoop();
    return 0;
}

$ g++ test.cpp -o test -lglut -lGLU -lGL -lX11 -lm
