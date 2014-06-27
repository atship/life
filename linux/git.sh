#想要删除上一个提交(commit)
git reset --hard HEAD~1

#想要删除某个版本的提交
git reset --hard commit-id

#删除了某一个提交导致相应的文件从硬盘被删除,但未被git垃圾回收
git reflog #查看被删除的提交的hash值,从中找到自己需要的hash
git reset --hard commit-id #这个commit-id为被删除的commit的hash值,此时被删除的文件被找回来了
/*当使用git reset --hard commit-id/HEAD~1的时候,硬盘上相应的文件将会被删除,如果git未垃圾回收,还来得及找回,否则就找不回了*/

#与原作者同步的步骤
git checkout -b origin-author-master master
git pull https://github.com/origin-author/origin-repos master
#fix the conflicts if exist
git commit -m "conflicts fixed"
git checkout master
git merge origin-author-master
git push origin master

#.gitignore忽略文件
#第一种方式，只忽略本工程，则在本工程的根目录下创建.gitignore文件，输入要忽略的内容
Directory/
fileName
*.h
!this-must-track-even-if-set-ignored.h
*.tmp
*~

#第二种方式，全局忽略，则你创建的所有工程都将会忽略指定的文件，创建文件同第一种方法，但可以存放到任意目录下，使用以下命令生效
git config --global core.excludesfile /file-path/to/.gitignore

#处理冲突，可以先安装meld或者其他合并工具，如果没有安装，下面的命令将会提示
git mergetool

#从.git目录检出文件，这样做可以只备份.git目录，而不需要将临时文件也打包
git checkout -f
