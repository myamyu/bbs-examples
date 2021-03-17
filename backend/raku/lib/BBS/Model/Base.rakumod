unit role BBS::Model::Base does Associative[Any, Str];

method hash() {...}

method list() {
    my %h = self.hash;
    return %h.list;
}
