use v6.c;
use Test;
use Algorithm::DawkinsWeasel;

my $weasel = Algorithm::DawkinsWeasel.new;

pass $weasel.isa: 'Algorithm::DawkinsWeasel';

pass $weasel.target-phrase eq 'METHINKS IT IS LIKE A WEASEL';
pass $weasel.mutation-threshold == 0.05;
pass $weasel.copies == 100;

for $weasel.evolution {
    say .count.fmt('%04d '), .current-phrase, ' [', .hi-score, ']';
}

pass $weasel.current-phrase eq 'METHINKS IT IS LIKE A WEASEL';

done-testing;
