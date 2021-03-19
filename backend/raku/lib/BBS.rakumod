use BBS::Model::Thread;
use BBS::Model::ThreadList;
use BBS::Repository::BBSRepository;

# アイテムが見つからないエラー
class BBS::Error::NotFound is Exception {}

# validationエラー
class BBS::Error::Invalid is Exception {}

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
        # TODO バリデーション

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

        unless thread.defined {
            die BBS::Error::NotFound.new;
        }
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

        # TODO バリデーション

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