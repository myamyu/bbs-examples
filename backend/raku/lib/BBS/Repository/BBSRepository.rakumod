use BBS::Model::Thread;
use BBS::Model::Comment;
use BBS::Model::ThreadList;

unit role BBS::Repository::BBSRepository;

method getThreads(
    Int :$offset,
    Int :$limit,
    Str :$sort,
    --> BBS::Model::ThreadList
) {...}

method createThread(
    Str :$title,
    Str :$body,
    Str :$author_name,
    Str[] :@tags = [],
    --> BBS::Model::Thread
) {...}

method getThread(
    Str :$thread_id,
    --> BBS::Model::Thread
) {...}

method addComment(
    Str :$thread_id,
    Str :$body,
    Str :$author_name,
    Int :$parent_comment_id,
    --> BBS::Model::Comment
) {...}

method getThreadComments(
    Str :$thread_id,
    --> BBS::Model::Comment[]
) {...}
