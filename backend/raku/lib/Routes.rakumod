use Cro::HTTP::Router;

sub routes() is export {
    route {
        get -> {
            content "text/html", "<h1> bbs </h1>";
        }
        # /threads
        get -> "threads" {
            my %res = (
                threadsCount => 0,
                start => 0,
                count => 0,
                threads => [],
            );
            content "application/json", %res;
        }
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
