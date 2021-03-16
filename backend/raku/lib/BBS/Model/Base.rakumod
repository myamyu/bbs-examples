unit role BBS::Model::Base does Associative;

method to_hash() {...}

method list() {
    my %h = self!to_hash();
    return %h.list;
}
