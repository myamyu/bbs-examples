use BBS::Model::Thread;
use BBS::Model::Base;

unit class BBS::Model::ThreadList does BBS::Model::Base;

has Int $.threads_count;
has Int $.start;
has Int $.count;
has BBS::Model::Thread @.threads;

method to_hash() {
    return (
        start => $.start,
        count => $.count,
        threadsCount => $.threads_count,
        threads => $.threads,
    );
}
