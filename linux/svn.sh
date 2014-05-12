#创建工程project到仓库/var/svn
cd /var/svn
svnadmin create project

#检出工程project到当前目录，并重命名为new_project_name
#project所在svn仓库路径为svn://127.0.0.1/
#svn分配的账号密码分别是account, 123456
svn co svn://127.0.0.1/project new_project_name --username account --password 123456

#添加文件到版本控制
#欲添加的文件file_for_add
svn add file_for_add

#添加目录到版本控制
#欲添加的目录folder_for_add
svn add folder_for_add

#从版本控制中移除文件file_for_delete
#文件已提交到仓库的情况下，使用这种方法将会从目录中删除文件
svn delete file_for_delete
#文件未提交到仓库的情况下，使用这种方法，该文件不会丢失
svn revert file_for_delete

#从版本控制中移除目录folder_for_delete
#文件已提交到仓库的情况下，使用这种方法将会从目录中删除目录
svn delete folder_for_delete
#文件未提交到仓库的情况下，使用这种方法，该目录不会丢失
#如果folder_for_delete中还有其他文件或者目录的话，需要添加 --depth infinity 选项才能成功还原
svn revert folder_for_delete --depth infinity

#提交更改到版本库 project
#svn分配的账号密码为account, 123456
svn ci --username account --password 123456

#更新当前目录
#svn分配的账号密码为account, 123456
svn update ./ --username account --password 123456

#当前文件夹被rm掉了想要还原(未从版本库中删除)
svn update --force folder-deleted

#查看当前工作目录的信息
svn info

#为当前目录"."添加ignore
svn propset svn:ignore "*.o
*.so
*.tmp
bin
gen
out
" .

#svn 账号分配
vi conf/passwd 在这里面添加账号密码，修改或删除用户也在这里
vi conf/authz 在这里设置权限，要设置某个目录的权限需要写全路径，比如[/A-project], [/B-project/B-subproject]

#删除账号缓存信息
rm ~/.subversion/auth/svn.simple/*
