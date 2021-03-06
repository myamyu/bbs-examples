use BBS::Model::Thread;
use BBS::Model::Comment;
use BBS::Model::ThreadList;
use BBS::Repository::BBSRepository;

unit class BBS::Repository::BBSMockRepository does BBS::Repository::BBSRepository;

has BBS::Model::Thread @!threads = [];
has BBS::Model::Comment @!comments = [];

my %sortThread = (
    "creation_desc" => {$^b.creation_time cmp $^a.creation_time},
    "creation_asc" => {$^a.creation_time cmp $^b.creation_time},
    "update_desc" => {$^b.update_time cmp $^a.update_time},
    "update_asc" => {$^a.update_time cmp $^b.update_time},
);

method getThreads(
    Int :$offset,
    Int :$limit,
    Str :$sort,
    --> BBS::Model::ThreadList
) {
    my $_sort = $sort;
    unless %sortThread{$_sort}:exists {
        $_sort = "update_desc";
    }
    my @threads = @!threads.sort(%sortThread{$_sort});

    my $_offset = $offset;
    if $_offset >= @threads.elems {
        $_offset = 0;
    }

    my $_limit = $limit;
    if $_offset + $_limit > @threads.elems {
        $_limit = @threads.elems - $_offset;
    }

    my $res = BBS::Model::ThreadList.new(
        threads_count => @!threads.elems,
        start => $_offset,
        count => $_limit,
        threads => @threads[$_offset..^($_offset + $_limit)],
    );
    return $res;
}

method createThread(
    Str :$title,
    Str :$body,
    Str :$author_name,
    :@tags where Array = [],
    --> BBS::Model::Thread
) {
    my $uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx';
    $uuid ~~ s:global/x/{"0123456789abcdef".comb[Int(16.rand)]}/;
    $uuid ~~ s:global/y/{"89ab".comb[Int(4.rand)]}/;

    my $now = DateTime.now;
    my $thread = BBS::Model::Thread.new(
        thread_id => $uuid,
        title => $title,
        body => $body,
        author_name => $author_name,
        tags => @tags,
        creation_time => $now,
        update_time => $now,
    );

    @!threads.push($thread);

    return $thread;
}

method getThread(
    Str :$thread_id,
    --> BBS::Model::Thread
) {
    return @!threads.first: -> $t {$t.thread_id === $thread_id};
}

method addComment(
    Str :$thread_id,
    Str :$body,
    Str :$author_name,
    :$parent_comment_id,
    --> BBS::Model::Comment
) {
    my $nextId = 1;
    my @cs = @!comments.grep: -> $c {$c.thread_id === $thread_id};
    if @cs.elems > 0 {
        my $latest = @cs.sort({$^b.creation_time cmp $^a.creation_time})[0];
        $nextId = $latest.comment_id + 1;
    }

    my $now = DateTime.now;
    my $comment = BBS::Model::Comment.new(
        comment_id => $nextId,
        thread_id => $thread_id,
        body => $body,
        author_name => $author_name,
        parent_comment_id => $parent_comment_id,
        creation_time => $now,
    );

    @!comments.push($comment);
    return $comment;
}

method getThreadComments(
    Str :$thread_id,
    --> Array
) {
    my @cs = @!comments.grep: -> $c {$c.thread_id === $thread_id};
    return @cs;
}
