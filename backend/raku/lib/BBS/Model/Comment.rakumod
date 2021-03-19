use BBS::Model::Article;

unit class BBS::Model::Comment does BBS::Model::Article;

has Str $.thread_id is required;
has Int $.comment_id;
has $.parent_comment_id;

method hash() {
    return (
        body => $.body,
    );
}
