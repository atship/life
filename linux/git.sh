#想要删除上一个提交(commit)
git reset --hard HEAD~1

#想要删除某个版本的提交
git reset --hard commit-id

#删除了某一个提交导致相应的文件从硬盘被删除,但未被git垃圾回收
git reflog #查看被删除的提交的hash值,从中找到自己需要的hash
git reset --hard commit-id #这个commit-id为被删除的commit的hash值,此时被删除的文件被找回来了
/*当使用git reset --hard commit-id/HEAD~1的时候,硬盘上相应的文件将会被删除,如果git未垃圾回收,还来得及找回,否则就找不回了*/

#重整历史记录，从最新的变动开始修改
#将在分支develop上的修改，生成patch，在master分支上重演一遍，下图中，feature分支在merge之后，不可再使用rebase，免得merge的历史丢失以致于历史混乱
#在rebase的时候，有可能会产生冲突，因为要生成patch，此时需要手动解决，然后 git rebase --continue，如果要放弃，则使用 git rebase --abort
git rebase master develop
                                                                        after rebase
master  commit - commit - commit - merge - commit - commit - commit - commit1' - commit2'
            \                     /           \                     /
feature    commit - commit - commit          commit - commit - commit
                                                \                 /
develop                                          commit1 - commit2

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

#轻量clone(git clone git://host/proj.git --depth=1)以后，需要获取全部历史记录的时候
git fetch --unshallow

git搭建服务器
1, ssh
    在服务器上创建一个git仓库，给客户端一个登录账号密码即可
    客户端使用 git clone user@server:path/to/proj.git
    之后即可使用 git push/git pull
    
2, git
    此协议最好用来做只读服务器，因为它没有权限控制，无需认证，一旦开启push操作，任何人都可以往工程中push他们的东西
    在服务器上创建一个git仓库，并执行git daemon --export-all --base-path=path/to/repos [--enable=receive-pack(允许客户端push)] [<path/to/repos/proj.git>, ...] &
    在客户端上使用 git clone git://server/proj.git
    之后即可使用git pull保持与服务器端同步
    
3，windows下的git有个BUG，需要设置一下才能push到以git协议搭建的服务器上
	git config --global sendpack.sideband false

/**
 *
 * git model : tree-blob-commit-tag
 *
 *  tree # git write-tree/read-tree
 *    +---- blob
 *    +---- tree
 *            +----blob
 *
 *  commit # git commit-tree
 *    +---- root-tree
 *    +---- parent-commit
 *
 *  refs/heads/master[branch] # git update-ref refs/heads/master commit-sha1
 *    +---- commit
 *
 *  refs/tags/tag-name # git tag [-a] tag-name [-m msg]
 *    +---- commit[tree][blob]
 *
 *  refs/remotes/origin[others]/HEAD # git remote add origin[others] url
 *    +---- refs/remotes/origin[others]/master[branch]
 *
 *  refs/remotes/origin[others]/master[branch]
 *    +---- commit
 *
 *  HEAD
 *    +---- refs/heads/master[branch]
 *
 *  index # git ls-files --stage / git update-index --add file
 *    +---- blob
 *
 *  config: # git config --global ..
 *  [remote "origin"]
 *      url = git://github.com/myname/myrepo.git
 *      fetch = +refs/heads/master[*]:refs/remotes/origin/master[*]
 *      fetch = ...
 *      push = refs/heads/master[*]:refs/heads/[QA][PROGRAMMER][namespace]/master[*]
 *
 *  git gc
 *    +---- objects/pack/pack-sha1.idx # git verify-pack -v .git/objects/pack/pack-sha1.idx
 *    +---- objects/pack/pack-sha1.pack
 *    +---- packed-refs
 *
 *  git history and branch
 *  master: commit--commit--commit--commit--commit--commit
 *                     \                     /
 *  branch:            commit--commit--commit
 *
 */