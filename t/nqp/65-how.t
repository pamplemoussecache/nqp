#!./parrot nqp.pbc

# check subs

plan(7);

class Foo {
    has $!foo_attr;
}
class Bar is Foo {
    has $!bar_attr;
}

my $foo := Foo.new();
my @Foo-attrs := $foo.HOW.attributes($foo,:local(1));
ok(@Foo-attrs[0].name eq '$!foo_attr',"we can get an attribute");
my $bar := Bar.new();
ok(+$bar.HOW.attributes($bar,:local(1)) == 1,"we only get local attributes");
ok(+$bar.HOW.attributes($bar,:local(0)) == 2,"we get all attributes");
ok($bar.HOW.attributes($bar) == 2,"we can skip :local");

class Baz {
}

my $baz := Baz.new();
my $NQPAttribute := @Foo-attrs[0].WHAT;
ok($NQPAttribute.HOW.name($NQPAttribute) eq 'NQPAttribute',"attributes are NQPAttributes");
$baz.HOW.add_attribute($baz,$NQPAttribute.new(:name('$!baz_attr')));
ok($baz.HOW.attributes($baz) == 1,"the right numer of attributes after adding");
ok($baz.HOW.attributes($baz)[0].name == '$!baz_attr',"we can add an attribute");


