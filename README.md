NAME
====

Algorithm::DawkinsWeasel - An Illustration of Cumulative Selection

SYNOPSIS
========

```
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
  }
```

DESCRIPTION
===========

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

AUTHOR
======

Jaldhar H. Vyas <jaldhar@braincells.com>

COPYRIGHT AND LICENSE
=====================

Copyright (C) 2017, Consolidated Braincells Inc.  All rights reserved.

This distribution is free software; you can redistribute it and/or modify it
under the terms of either:

a) the GNU General Public License as published by the Free Software
Foundation; either version 2, or (at your option) any later version, or

b) the Artistic License version 2.0.

The full text of the license can be found in the LICENSE file included
with this distribution.

