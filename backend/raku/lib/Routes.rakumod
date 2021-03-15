use Cro::HTTP::Router;
use BBS::Repository::BBSRepository;
use BBS::Service::BBSService;

sub routes(BBS::Repository::BBSRepository $repo) is export {
    my $service = BBS::Service::BBSService.new(
        repository => $repo,
    );
    route {
        get -> {
            content "text/html", "<h1> bbs </h1>";
        }
        # get /threads
        get -> "threads" {
            # TODO QueryStringから取ってくる
            my $threads = $service.getThreads(
                offset => 0,
                limit => 5,
                sort => "update_desc",
            );
            my %res = (
                threadsCount => $threads.threads_count,
                start => $threads.start,
                count => $threads.count,
                threads => $threads.threads,
            );
            content "application/json", %res;
        }

        # post /threads
        post -> "threads" {
            request-body "application/json" => -> %req {
                my %res = (
                    message => "ok",
                );
                content "application/json", %res;
            }
        }
    }
}
