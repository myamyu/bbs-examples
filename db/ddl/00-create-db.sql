create role if not exists bbs login password 'bbs';
create database if not exists bbs;
grant all privileges on database bbs to bbs;
