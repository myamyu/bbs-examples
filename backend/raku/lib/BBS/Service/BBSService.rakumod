use BBS::Model::Thread;
use BBS::Model::ThreadList;
use BBS::Repository::BBSRepository;

unit class BBS::Service::BBSService;

has BBS::Repository::BBSRepository $.repository;

method getThreads(
    Int :$offset = 0,
    Int :$limit = 10,
    Str :$sort = "update_desc",
    --> BBS::Model::ThreadList
) {
    return self.repository.getThreads(
        offset => $offset,
        limit => $limit,
        sort => $sort,
    );
}

method createThread(
    Str :$title,
    Str :$body,
    Str :$author_name,
    :@tags where Array = [],
    --> BBS::Model::Thread
) {
    # TODO バリデーション

    return self.repository.createThread(
        title => $title,
        body => $body,
        author_name => $author_name,
        tags => @tags,
    );
}
