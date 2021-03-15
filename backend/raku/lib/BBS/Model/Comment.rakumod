use BBS::Model::Article;

=head2 BBS::Model::Comment;

unit class BBS::Model::Comment does BBS::Model::Article;

has Str $.thread_id is required;
has Int $.comment_id;
has Int $.parent_comment_id;
