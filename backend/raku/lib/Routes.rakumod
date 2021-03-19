use Cro::HTTP::Router;
use BBS::Repository::BBSRepository;
use BBS;

sub routes(BBS::Repository::BBSRepository $repo) is export {
    my $service = BBS::BBSService.new(
        repository => $repo,
    );
    route {
        get -> {
            content "text/html", "<h1> bbs </h1>";
        }

        # get /threads
        get -> "threads", :$offset, :$limit, :$sort {
            my %threads = $service.getThreads(
                offset => $offset.defined ?? Int($offset) !! 0,
                limit => $limit.defined ?? Int($limit) !! 10,
                sort => $sort.defined ?? $sort !! "update_desc",
            );
            content "application/json", %threads;
        }

        # post /threads
        post -> "threads" {
            request-body "application/json" => -> %req {
                my %thread = $service.createThread(
                    title => %req<title>,
                    body => %req<body>,
                    author_name => %req<name>,
                    tags => %req<tags>,
                );
                content "application/json", %thread;
                CATCH {
                    when BBS::Error::Invalid {
                        bad-request;
                    }
                }
            }
        }

        # get /threads/{threadId}
        get -> "threads", $thread_id {
            my %thread = $service.getThread(
                thread_id => $thread_id,
            );
            my @comments = $service.getThreadComments(
                thread_id => $thread_id,
            );

            my %res = (
                thread => %thread,
                comments => @comments,
            );
            content "application/json", %res;
            CATCH {
                when BBS::Error::NotFound {
                    not-found;
                }
            }
        }

        # /threads/{threadId}/comments
        post -> "threads", $thread_id, "comments" {
            request-body "application/json" => -> %req {
                my %comment = $service.addComment(
                    thread_id => $thread_id,
                    body => %req<body>,
                    author_name => %req<name>,
                    parent_comment_id => %req<parentComment>,
                );
                content "application/json", %comment;
                CATCH {
                    when BBS::Error::NotFound {
                        not-found;
                    }
                    when BBS::Error::Invalid {
                        bad-request;
                    }
                }
            }
        }
    }
}
