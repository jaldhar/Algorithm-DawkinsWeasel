use v6.c;

=begin pod

=head1 NAME

Algorithm::DawkinsWeasel - An Illustration of Cumulative Selection

=head1 SYNOPSIS

  use Algorithm::DawkinsWeasel;

  my $weasel = Algorithm::DawkinsWeasel.new(
    target-phrase      => 'METHINKS IT IS LIKE A WEASEL',
    mutation-threshold => 0.05,
    copies             => 100,
  );
    
  repeat {
    given $weasel {
      say .count.fmt('%04d'), ' ', .current-phrase, ' [', .hi-score, ']';
    }
  } until $weasel.evolve;



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

=end pod

unit class Algorithm::DawkinsWeasel:ver<0.0.1>;

has Str @!charset;
has Str @.target-phrase;
has Rat $.mutation-threshold;
has Int $.copies;
has Str @.current-phrase;
has Int $.hi-score;
has Int $.count;


submethod BUILD(Str :$target-phrase = 'METHINKS IT IS LIKE A WEASEL',
Rat :$mutation-threshold = 0.05, Int :$copies = 100) {
    @!charset  = | ['A' .. 'Z'] , ' ';
    @!target-phrase = $target-phrase.comb;
    $!mutation-threshold = $mutation-threshold;
    $!copies = $copies;

    @!current-phrase = map { @!charset.pick }, 0 .. @!target-phrase.end;
    $!hi-score = 0;
    $!count = 0;
}


method evolve() {
    $!count++;

    for (1 .. $!copies) {
        my @trial = map {
            1.rand < $!mutation-threshold ?? @!charset.pick !! $_;
        }, @!current-phrase;
        
        my Int $score = 0;
        for 0 .. @!target-phrase.end -> $i {
            if @trial[$i] eq @!target-phrase[$i] {
                $score++;
            }
        }

        if $score > $!hi-score {
            $!hi-score = $score;
            @!current-phrase = @trial;
        }
    }

    return ($!hi-score == @!target-phrase.elems);
}

method current-phrase() {
    return @!current-phrase.join('');
}

method target-phrase() {
    return @!target-phrase.join('');
}

=begin pod

=head1 SEE ALSO

L<Weasel Program at Wikipedia|https://en.wikipedia.org/wiki/Weasel_program>

=head1 AUTHOR

Jaldhar H. Vyas <jaldhar@braincells.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2017, Consolidated Braincells Inc.  All rights reserved.

This distribution is free software; you can redistribute it and/or modify it
under the terms of either:

a) the GNU General Public License as published by the Free Software
Foundation; either version 2, or (at your option) any later version, or

b) the Artistic License version 2.0.

The full text of the license can be found in the LICENSE file included
with this distribution.

=end pod
