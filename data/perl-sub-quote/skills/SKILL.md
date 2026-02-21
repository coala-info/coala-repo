---
name: perl-sub-quote
description: The `perl-sub-quote` (Sub::Quote) tool provides a mechanism for generating Perl subroutines from strings.
homepage: http://metacpan.org/pod/Sub::Quote
---

# perl-sub-quote

## Overview
The `perl-sub-quote` (Sub::Quote) tool provides a mechanism for generating Perl subroutines from strings. Unlike standard anonymous subs, these "quoted subs" can be inlined into other strings of code, allowing the Perl compiler to optimize the resulting combined string. This is particularly useful in meta-programming, attribute handlers, or ORM-like systems where many small, similar subroutines are generated at runtime.

## Core Subroutines

### quote_sub
Generates a coderef from a string. By default, it creates a "deferred" sub that is only compiled when first called.

```perl
use Sub::Quote qw(quote_sub);

my $handler = quote_sub 'My::Package::handler', q{
    my ($self, $val) = @_;
    print "Processing $val in " . __PACKAGE__;
}, { 
    # Optional captures (variables from current scope)
    '$prefix' => \$prefix_var 
};
```

**Key Options:**
- `no_defer => 1`: Compiles the sub immediately. Use this if you know the sub will be called right away.
- `no_install => 1`: Prevents the sub from being installed into the package namespace provided in the first argument.
- `package => 'Other::Pkg'`: Sets the evaluation context.

### unquote_sub
Forces immediate compilation of a deferred subroutine.
```perl
unquote_sub($deferred_coderef);
```

### qsub
A shorthand for `quote_sub` that only takes the code string. Useful for clean syntax in hash definitions.
```perl
my %dispatch = (
    get => qsub q{ return $self->{data} },
    set => qsub q{ $self->{data} = $_[1] },
);
```

## Inlining and Utilities

### inlinify
Converts a code string into a format suitable for embedding inside another string eval.
```perl
use Sub::Quote qw(inlinify capture_unroll);

my $prelude = capture_unroll '$captures', { '$x' => \$val }, 4;
my $code = inlinify q{ say "Value is $x" }, '$arg1, $arg2', $prelude;
```

### quotify
Safely quotes a scalar value (string, number, or undef) for inclusion in a generated code string.
```perl
my $string_for_eval = quotify($raw_value);
my $code = "my \$val = $string_for_eval; ...";
```

## Best Practices
- **Avoid `return`**: Do not use `return` inside a `quote_sub` string if you intend to inline it later. A `return` will exit the entire calling function, not just the inlined block.
- **Use Captures for Lexicals**: Instead of interpolating variables directly into the string (which can lead to injection bugs), use the captures hashref to pass references to lexical variables.
- **Debugging**: Set the environment variable `SUB_QUOTE_DEBUG=1` to see the generated code sent to `eval` printed to STDERR. You can also use regex patterns like `SUB_QUOTE_DEBUG=/Pattern/`.
- **Performance**: Use `no_defer => 1` for subroutines that are guaranteed to be executed to avoid the small overhead of the Sub::Defer wrapper.

## Reference documentation
- [Sub::Quote - Efficient generation of subroutines via string eval](./references/metacpan_org_pod_Sub__Quote.md)