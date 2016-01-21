use v6;
use Test;
use-ok 'Algorithm::AhoCorasick';
use Algorithm::AhoCorasick;

{
    my $aho-corasick = Algorithm::AhoCorasick.new(keywords => ['corasick']);
    my $actual = $aho-corasick.match('corasick');
    my $expected = set('corasick');
    is-deeply $actual, $expected, "It should match a keyword";
}

{
    my $aho-corasick = Algorithm::AhoCorasick.new(keywords => ['corasick']);
    my $actual = $aho-corasick.match('corasic');
    my $expected = set();
    is-deeply $actual, $expected, "It should match none of words";
}

{
    my $aho-corasick = Algorithm::AhoCorasick.new(keywords => ['corasick','sick','co','si']);
    my $actual = $aho-corasick.match('corasick');
    my $expected = set('corasick','co','si','sick');
    is-deeply $actual, $expected, "It should match all keywords";
}

{
    my $aho-corasick = Algorithm::AhoCorasick.new(keywords => ['It\'s a piece of cake']);
    my $actual = $aho-corasick.match('Tom said "It\'s a piece of cake."');
    my $expected = set('It\'s a piece of cake');
    is-deeply $actual, $expected, "It should match a keyword including whitespaces";
}

# Easy Japanese test
{
    my $aho-corasick = Algorithm::AhoCorasick.new(keywords => ['駄菓子','菓子','洋菓子']);
    my $actual = $aho-corasick.match('駄菓子と洋菓子どちらが良いか悩ましい。');
    my $expected = set('駄菓子','洋菓子','菓子');
    is-deeply $actual, $expected, "It should match all Japanese keywords";
}

done-testing;
