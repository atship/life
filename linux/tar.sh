#从文件folder1, folder2, file1, file2, flie3创建target.tar文件
tar cf target.tar folder1 folder2 file1 file2 file3

#从文件folder1, folder2, file1, file2, file3创建target.tar.gz文件
tar czf target.tar.gz folder1 folder2 file1 file2 file3

#从文件folder1, folder2, file1, file2, file3创建target.tar.bz2文件
tar cjf target.tar.bz2 folder1 folder2 file1 file2 file3

#从文件target.tar中解压文件到/var/www目录
tar xf target.tar -C /var/www

#从文件target.tar.gz中解压文件到/var/www目录
tar xzf target.tar.gz -C /var/www

#从文件target.tar.bz2中解压文件到/var/www目录
tar xjf target.tar.bz2 -C /var/www

#最新版tar新增.xz文件类型
tar xJf target.xz -C /var/www

#最新版tar新增.z文件类型
tar xZf target.z -C /var/www