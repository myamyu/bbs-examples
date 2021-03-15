unit role BBS::Model::Article;

has Str $.body is required;
has Str $.author_name is required;
has DateTime $.creation_time;
has DateTime $.delete_time;

method is_delete {
    return self.delete_time.defined;
}
