use v6.c;
use Test;
use Algorithm::DawkinsWeasel;

my $weasel = Algorithm::DawkinsWeasel.new;

pass $weasel.isa: 'Algorithm::DawkinsWeasel';

pass $weasel.target-phrase eq 'METHINKS IT IS LIKE A WEASEL';
pass $weasel.mutation-threshold == 0.05;
pass $weasel.copies == 100;

repeat {
    say $weasel.current-phrase;
} until $weasel.evolve;
say $weasel.current-phrase;

pass $weasel.current-phrase eq 'METHINKS IT IS LIKE A WEASEL';

done-testing;
