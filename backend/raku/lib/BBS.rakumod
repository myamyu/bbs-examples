use BBS::Model::Thread;
use BBS::Model::ThreadList;
use BBS::Repository::BBSRepository;

# アイテムが見つからないエラー
class BBS::Error::NotFound is Exception {}

# validationエラー
class BBS::Error::Invalid is Exception {
    has @.errors = [];
}

class BBS::BBSService {
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
        # バリデーション
        my @invalid = [];
        if not $title.defined or $title eq "" {
            @invalid.push(%(
                field => "title",
                message => "タイトルが指定されていません",
            ));
        }

        if not $body.defined or $body eq "" {
            @invalid.push(%(
                field => "body",
                message => "内容が指定されていません",
            ));
        }

        if not $author_name.defined or $author_name eq "" {
            @invalid.push(%(
                field => "name",
                message => "名前が指定されていません",
            ));
        }

        # 入力エラーがあったらInvalidを発火
        die BBS::Error::Invalid.new(errors => @invalid) if @invalid.elems > 0;

        return self.repository.createThread(
            title => $title,
            body => $body,
            author_name => $author_name,
            tags => @tags,
        );
    }

    method getThread(
        Str :$thread_id,
        --> BBS::Model::Thread
    ) {
        my \thread = self.repository.getThread(
            thread_id => $thread_id,
        );

        die BBS::Error::NotFound.new unless thread.defined;
        return thread;
    }

    method addComment(
        Str :$thread_id,
        Str :$body,
        Str :$author_name,
        :$parent_comment_id,
        --> BBS::Model::Comment
    ) {
        # threadがあるかどうかの確認用
        my $thread = self.getThread(
            thread_id => $thread_id
        );

        # バリデーション
        my @invalid = [];
        if not $body.defined or $body eq "" {
            @invalid.push(%(
                field => "body",
                message => "内容が指定されていません",
            ));
        }

        if not $author_name.defined or $author_name eq "" {
            @invalid.push(%(
                field => "name",
                message => "名前が指定されていません",
            ));
        }

        # 入力エラーがあったらInvalidを発火
        die BBS::Error::Invalid.new(errors => @invalid) if @invalid.elems > 0;

        my $comment = self.repository.addComment(
            thread_id => $thread.thread_id,
            body => $body,
            author_name => $author_name,
            parent_comment_id => $parent_comment_id,
        );
        return $comment;
    }

    method getThreadComments(
        Str :$thread_id,
        --> Array
    ) {
        return self.repository.getThreadComments(
            thread_id => $thread_id,
        );
    }
}
