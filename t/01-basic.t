use v6.c;
use Test;
use P5shift;

plan 10;

ok defined(::('&shift')),           'is &shift imported?';
ok !defined(P5shift::{'&shift'}),   'is &shift externally NOT accessible?';
ok defined(::('&unshift')),         'is &unshift imported?';
ok !defined(P5shift::{'&unshift'}), 'is &unshift externally NOT accessible?';

my @a = 1;
is (unshift @a, 42), 2, 'does unshift return number of elems';
is @a, "42 1", 'did it actually unshift';

@*ARGS = <FOO BAR>;
is shift, "FOO", 'does bare shift shift from @*ARGS at top level';

is (shift @a),  42, 'does first specific shift also work';
is (shift @a),   1, 'does second specific shift also work';
is (shift @a), Nil, 'does third specific shift also work';

# vim: ft=perl6 expandtab sw=4
