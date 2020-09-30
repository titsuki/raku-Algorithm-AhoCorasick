use v6;
use Test;
use-ok 'Algorithm::AhoCorasick';
use Algorithm::AhoCorasick;

# locate
{
    my Algorithm::AhoCorasick $aho-corasick .= new(keywords => ['corasick']);
    my $actual = $aho-corasick.locate('corasick');
    my $expected = {'corasick' => [0]};
    is $actual, $expected, "Given a text that contains a keyword, .locate should match the keyword and return it with its location";
}

{
    my Algorithm::AhoCorasick $aho-corasick .= new(keywords => ['corasick']);
    my $actual = $aho-corasick.locate('corasic');
    my $expected = Hash;
    is $actual, $expected, "Given a text that doesn't contain any keywords, .locate should return a Hash type object";
}

{
    my Algorithm::AhoCorasick $aho-corasick .= new(keywords => ['corasick','sick','co','si']);
    my $actual = $aho-corasick.locate('corasick');
    my $expected = {'corasick' => [0],'co' => [0],'si' => [4],'sick' => [4]};
    is $actual, $expected, "Given a text that contains some keywords, .locate should match all of the keywords and return these with each locations";
}

{
    my Algorithm::AhoCorasick $aho-corasick .= new(keywords => ['It\'s a piece of cake']);
    my $actual = $aho-corasick.locate('Tom said "It\'s a piece of cake."');
    my $expected = {'It\'s a piece of cake' => [10]};
    is $actual, $expected, "Given a text that contains a keyword composed of some whitespaces and alphabetic characters, .locate should match the keyword and return it with its location";
}

# Easy Japanese test
{
    my Algorithm::AhoCorasick $aho-corasick .= new(keywords => ['駄菓子','菓子','洋菓子']);
    my $actual = $aho-corasick.locate('駄菓子と洋菓子どちらが良いか悩ましい。');
    my $expected = {'駄菓子' => [0],'洋菓子' => [4],'菓子' => [1,5]};
    is $actual, $expected, "Given a text that contains Japanese keyword, .locate should match all Japanese keywords and return these with each locations";
}

# match
{
    my Algorithm::AhoCorasick $aho-corasick .= new(keywords => ['corasick']);
    my $actual = $aho-corasick.match('corasick');
    my $expected = set('corasick');
    ok $actual ~~ $expected, "Given a text that contains a keyword, .match should match the keyword and return it";
}

{
    my Algorithm::AhoCorasick $aho-corasick .= new(keywords => ['corasick']);
    my $actual = $aho-corasick.match('corasic');
    my $expected = Set;
    ok $actual ~~ $expected, "Given a text that doesn't contain any keywords, .match should match none of words and return a Set type object";
}

{
    my Algorithm::AhoCorasick $aho-corasick .= new(keywords => ['corasick','sick','co','si']);
    my $actual = $aho-corasick.match('corasick');
    my $expected = set('corasick','co','sick','si');
    ok $actual ~~ $expected, "Given a text that contains some keywords, .match should match all of the keywords and return these";
}

{
    my Algorithm::AhoCorasick $aho-corasick .= new(keywords => ['It\'s a piece of cake']);
    my $actual = $aho-corasick.match('Tom said "It\'s a piece of cake."');
    my $expected = set('It\'s a piece of cake');
    ok $actual ~~ $expected, "It should match a keyword including whitespaces";
}

# Easy Japanese test
{
    my Algorithm::AhoCorasick $aho-corasick .= new(keywords => ['駄菓子','菓子','洋菓子']);
    my $actual = $aho-corasick.match('駄菓子と洋菓子どちらが良いか悩ましい。');
    my $expected = set('駄菓子','洋菓子','菓子');
    ok $actual ~~ $expected, "It should match all Japanese keywords";
}

done-testing;
