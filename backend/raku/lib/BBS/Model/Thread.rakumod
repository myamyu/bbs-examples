use BBS::Model::Article;

unit class BBS::Model::Thread does BBS::Model::Article;

has Str $.thread_id;
has Str $.title is required;
has Str[] @.tag;
