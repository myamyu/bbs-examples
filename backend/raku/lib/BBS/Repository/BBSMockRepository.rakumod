use BBS::Model::Thread;
use BBS::Model::Comment;
use BBS::Model::ThreadList;
use BBS::Repository::BBSRepository;

unit class BBS::Repository::BBSMockRepository does BBS::Repository::BBSRepository;

method getThreads(
    Int :$offset,
    Int :$limit,
    Str :$sort,
    --> BBS::Model::ThreadList
) {
    my $res = BBS::Model::ThreadList.new(
        threads_count => 10,
        start => $offset,
        count => $limit,
        threads => [],
    );
    return $res;
}

method createThread(
    Str :$title,
    Str :$body,
    Str :$author_name,
    Str[] :@tags = [],
    --> BBS::Model::Thread
) {
    return BBS::Model::Thread.new(
        thread_id => "7df4b357-f273-4f3f-898b-2f84243d366b",
        title => $title,
        body => $body,
        author_name => $author_name,
        tag => @tags,
    );
}

method getThread(
    Str :$thread_id,
    --> BBS::Model::Thread
) {
    return BBS::Model::Thread.new(
        thread_id => "1ba333cf-78fe-4d84-aa9c-cfb0876e2516",
        title => "title",
        body => "body",
        author_name => "author_name",
        tag => ["たぐ", "たぐ２"],
    );
}

method addComment(
    Str :$thread_id,
    Str :$body,
    Str :$author_name,
    Int :$parent_comment_id,
    --> BBS::Model::Comment
) {
    return BBS::Model::Comment.new(
        comment_id => 1,
        thread_id => $thread_id,
        body => $body,
        author_name => $author_name,
        parent_comment_id => $parent_comment_id,
    )
}

method getThreadComments(
    Str :$thread_id,
    --> BBS::Model::Comment[]
) {
    return [];
}
