#���ļ�folder1, folder2, file1, file2, flie3����target.tar�ļ�
tar cf target.tar folder1 folder2 file1 file2 file3

#���ļ�folder1, folder2, file1, file2, file3����target.tar.gz�ļ�
tar czf target.tar.gz folder1 folder2 file1 file2 file3

#���ļ�folder1, folder2, file1, file2, file3����target.tar.bz2�ļ�
tar cjf target.tar.bz2 folder1 folder2 file1 file2 file3

#���ļ�target.tar�н�ѹ�ļ���/var/wwwĿ¼
tar xf target.tar -C /var/www

#���ļ�target.tar.gz�н�ѹ�ļ���/var/wwwĿ¼
tar xzf target.tar.gz -C /var/www

#���ļ�target.tar.bz2�н�ѹ�ļ���/var/wwwĿ¼
tar xjf target.tar.bz2 -C /var/www

#���°�tar����.xz�ļ�����
tar xJf target.xz -C /var/www

#���°�tar����.z�ļ�����
tar xZf target.z -C /var/www