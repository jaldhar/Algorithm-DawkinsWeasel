use v6.c;
unit class Algorithm::DawkinsWeasel:ver<0.0.1>;

=begin pod

=head1 NAME

Algorithm::DawkinsWeasel - an illustration of cumulative selection

=head1 SYNOPSIS

  use Algorithm::DawkinsWeasel;

  my $weasel = Algorithm::DawkinsWeasel.new('METHINKS IT IS LIKE A WEASEL',
    0.05, 100);
    
  repeat {
    say $weasel.count().fmt('%04d'), ' ', $weasel.current-phrase(),
      " [$weasel.hi-score]";

  } while !$weasel.evolve();



=head1 DESCRIPTION

Algorithm::DawkinsWeasel is a simple model illustrating the idea of cumulative
selection in evolution.

The original form of it looked like this:

  1. Start with a random string of 28 characters.
  2. Make 100 copies of this string, with a 5% chance per character of that
     character being replaced with a random character.
  3. Compare each new string with "METHINKS IT IS LIKE A WEASEL", and give
     each a score (the number of letters in the string that are correct and
     in the correct position).
  4. If any of the new strings has a perfect score (== 28), halt.
  5. Otherwise, take the highest scoring string, and go to step 2

This module parametrizes the target string, mutation threshold, and number of
copies per round.

=cut

has Str @!charset;
has Str @.target-phrase;
has Rat $.mutation-threshold;
has Int $.copies;
has Str @.current-phrase;
has Int $.hi-score;
has Int $.count;


method BUILD(Str $target-phrase = 'METHINKS IT IS LIKE A WEASEL',
Rat $mutation-threshold = 0.05, Int $copies = 100) {
    @.charset  = | ['A' .. 'Z'] , ' ';
    @.target-phrase = $target-phrase.comb;
    $.mutation-threshold = $mutation-threshold;
    $.copies = $copies;

    @.current-phrase = map { @charset.pick }, 0 .. @.target-phrase.end;
    $.hi-score = 0;
    $.count = 0;
}


method evolve() {
    $.count++;

    for (1 .. $.copies) {
        my @trial = map {
            1.rand < $.mutation-threshold ?? @.charset.pick !! $_;
        }, @.current-phrase;
        
        my Int $score = 0;
        for 0 .. @.target-phrase.end -> $i {
            if @trial[$i] eq @.target-phrase[$i] {
                $score++;
            }
        }
        if $score > $.hi-score {
            $.hi-score = $score;
            @.current-phrase = @trial;
        }
    }

    return $.hi-score == @.target-phrase.elems;
}


=head1 SEE ALSO

L<https://en.wikipedia.org/wiki/Weasel_program|Weasel Program at Wikipedia>

=head1 AUTHOR

Jaldhar H. Vyas <jaldhar@braincells.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2017 Jaldhar H. Vyas

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
