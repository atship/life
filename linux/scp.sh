#当前所在服务器A，需要复制的文件为file1, file2, file3
#B服务器用户为user，SSH端口为22022，目标路径为/var/www：
scp file1 file2 file3  -P22022 user@B:/var/www/