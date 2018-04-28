use v6.c;

unit module P5shift:ver<0.0.1>:auth<cpan:ELIZABETH>;

proto sub shift(|) is export {*}
multi sub shift() {
    callframe(2).my<!UNIT_MARKER>:exists  # heuristic for top level calling
      ?? shift(@*ARGS)                      # top level, use @ARGV equivalent
      !! shift(CALLERS::<@_>)               # unshift from the caller's @_
}
multi sub shift(@array) {
    @array.elems ?? @array.shift !! Nil
}

proto sub unshift(|) is export {*}
multi sub unshift(@array,*@values --> Int:D) {
    @array.unshift(@values).elems
}

=begin pod

=head1 NAME

P5shift - Implement Perl 5's shift() / unshift() built-ins

=head1 SYNOPSIS

  use P5shift;

  say shift;  # shift from @*ARGS, if any

  sub a { dd @_; dd shift; dd @_ }; a 1,2,3;
  [1, 2, 3]
  1
  [2, 3]

  my @a = 1,2,3;
  say unshift @a, 42;  # 4

=head1 DESCRIPTION

This module tries to mimic the behaviour of the C<shift> and C<unshift> functions
of Perl 5 as closely as possible.

=head1 AUTHOR

Elizabeth Mattijsen <liz@wenzperl.nl>

Source can be located at: https://github.com/lizmat/P5shift . Comments and
Pull Requests are welcome.

=head1 COPYRIGHT AND LICENSE

Copyright 2018 Elizabeth Mattijsen

Re-imagined from Perl 5 as part of the CPAN Butterfly Plan.

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod