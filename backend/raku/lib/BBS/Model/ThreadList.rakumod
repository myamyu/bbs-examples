use BBS::Model::Thread;

unit class BBS::Model::ThreadList;

has Int $.threads_count;
has Int $.start;
has Int $.count;
has BBS::Model::Thread[] @.threads;
