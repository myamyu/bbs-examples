use BBS::Model::ThreadList;
use BBS::Repository::BBSRepository;

unit class BBS::Service::BBSService;

has BBS::Repository::BBSRepository $.repository;

method getThreads(
    Int :$offset,
    Int :$limit,
    Str :$sort,
    --> BBS::Model::ThreadList
) {
    return self.repository.getThreads(
        offset => $offset,
        limit => $limit,
        sort => $sort,
    );
}

