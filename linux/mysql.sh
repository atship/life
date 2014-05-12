#安装 (fedora 17)
sudo yum install mysql mysql-server mysql-workbench

#配置（字符集）
sudo vi /etc/my.cnf

#添加如下内容
[mysqladmin]
user=root

[mysqld]
character-set-server=UTF8

[client]
default-character-set=UTF8

#更改root初始密码为123456
mysqladmin -uroot password 123456

#当前root密码为123456，要更改为abc
mysqladmin -uroot -p123456 password abc

#添加一个新用户test,密码为1234，该用户可操作数据库site
#grant sudi on database to user at host identified by password
grant select,update,delete,insert on site.* to test@localhost identified by "1234";

#删除用户test@localhost，这个不会删除用户test@otherhost
drop user test@localhost

#创建数据库
mysql -uroot -p123456
create database mysite

#创建数据表
use mysite
create table user (
    userid varchar(10) not null,
    userage tinyint(3) default 0,
    primary key (userid)
)engine=myisam default charset=utf8;

#增加一条记录到数据表user
insert into user values('i am user1', 33);

#更改指定记录的某个字段
update user set age=44 where userid='i am user1';

#删除指定记录
delete from user where userid='i am user1';

#查看指定记录
select * from user where userid='i am user1';

#查看所有记录
select * from user;

#导出数据库全部表
mysqldump -uroot -p123456 mysite > /var/www/sql/mysite.sql

#导出数据库中的指定表
mysqldump -uroot -p123456 mysite site > /var/www/sql/mysite_site.sql

#导入数据表至数据库
#若数据库不存在，则先创建数据库　mysqladmin create mysite -uroot -p123456
mysql -uroot -p123456 mysite < /var/www/sql/mysite.sql