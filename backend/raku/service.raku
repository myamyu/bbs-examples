use Cro::HTTP::Log::File;
use Cro::HTTP::Server;
use Routes;
use BBS::Repository::BBSMockRepository;

# リポジトリを作成
my $repo = BBS::Repository::BBSMockRepository.new();

my Cro::Service $http = Cro::HTTP::Server.new(
    http => <1.1>,
    host => %*ENV<BBS_HOST> ||
        die("Missing BBS_HOST in environment"),
    port => %*ENV<BBS_PORT> ||
        die("Missing BBS_PORT in environment"),
    application => routes($repo),
    after => [
        Cro::HTTP::Log::File.new(logs => $*OUT, errors => $*ERR)
    ]
);
$http.start;
say "Listening at http://%*ENV<BBS_HOST>:%*ENV<BBS_PORT>";
react {
    whenever signal(SIGINT) {
        say "Shutting down...";
        $http.stop;
        done;
    }
}
