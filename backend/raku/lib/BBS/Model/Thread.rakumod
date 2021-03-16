use BBS::Model::Article;

unit class BBS::Model::Thread does BBS::Model::Article;

has Str $.thread_id;
has Str $.title is required;
has Str @.tags;
has DateTime $.update_time;

method to_hash() {
    return (
        id => $.thread_id,
        title => $.title,
        body => $.body,
        authorName => $.author_name,
        tags => $.tags,
        creationTime => $.creation_time,
    );
}
