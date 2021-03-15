use BBS::Model::Thread;

=head2 BBS::Repository::BBSRepository

unit role BBS::Repository::BBSRepository;

method createThread(
    Str :$title,
    Str :$body,
    Str :$author_name,
    Str[] :@tags = []
    --> BBS::Model::Thread
) {...}

method getThread(Str :$thiread_id --> BBS::Model::Thread) {...}
