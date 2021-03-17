-- extensions
create extension if not exists "uuid-ossp";

-- スレッド
create table if not exists bbs_thread (
    thread_id       uuid not null default uuid_generate_v1(),
    title           text not null,
    body            text not null,
    author_name     varchar(100) not null,
    creation_time   timestamp not null default current_timestamp,
    update_time   timestamp not null default current_timestamp,
    delete_time     timestamp,
    constraint thread_id primary key (thread_id)
);

-- コメント
create table if not exists bbs_comment (
    thread_id           uuid not null,
    comment_id          int not null,
    parent_comment_id   int,
    body                text not null,
    author_name         varchar(100) not null,
    creation_time       timestamp not null default current_timestamp,
    delete_time         timestamp,
    constraint comment_id primary key (thread_id, comment_id)
);

-- タグ
create table if not exists bbs_tag (
    tag_id      serial,
    tag_text    varchar(100) not null,
    constraint tag_id primary key (tag_id)
);

-- タグ x スレッド
create table if not exists bbs_thread_tag (
    thread_id   uuid not null,
    tag_id      int not null,
    constraint thread_tag_id primary key (thread_id, tag_id)
);
