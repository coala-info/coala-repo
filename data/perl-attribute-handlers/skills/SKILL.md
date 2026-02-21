---
name: perl-attribute-handlers
description: Attribute::Handlers is a core Perl module that simplifies the definition of custom attributes (e.g., `:MyAttr`).
homepage: https://github.com/tsee/Attribute-Handlers
---

# perl-attribute-handlers

## Overview

Attribute::Handlers is a core Perl module that simplifies the definition of custom attributes (e.g., `:MyAttr`). Traditionally, Perl requires complex manipulation of internal hooks like `MODIFY_CODE_ATTRIBUTES`; this module replaces that with a declarative syntax. Use this skill to implement specialized behaviors that trigger during compilation phases (BEGIN, CHECK, INIT, or END) when a specific attribute is encountered on a scalar, array, hash, or subroutine.

## Defining Attribute Handlers

To create a handler, define a subroutine with the name of the attribute you want to support and tag it with the `:ATTR` attribute.

### Basic Syntax
```perl
package MyModule;
use Attribute::Handlers;

# Handler for subroutines only
sub MySubAttr : ATTR(CODE) {
    my ($package, $symbol, $referent, $attr, $data, $phase) = @_;
    # Logic here
}

# Handler for any referent type
sub UniversalAttr : ATTR {
    my ($package, $symbol, $referent, $attr, $data) = @_;
    # Use ref($referent) to determine type
}
```

### Handler Arguments
Attribute handlers receive eight arguments in the following order:
1. **$package**: The name of the package where the attribute was declared.
2. **$symbol**: A reference to the typeglob (symbol table entry). For lexical variables, this is the string 'LEXICAL'; for anonymous subs, it is 'ANON'.
3. **$referent**: A reference to the actual object (SCALAR, ARRAY, HASH, or CODE).
4. **$attr**: The name of the attribute.
5. **$data**: The data associated with the attribute (e.g., the "val" in `:Attr(val)`).
6. **$phase**: The compilation phase in which the handler is invoked.
7. **$filename**: The file where the declaration occurred.
8. **$linenum**: The line number of the declaration.

## Data Parsing Rules

Attribute::Handlers attempts to parse the data passed to an attribute automatically:
- **Successful Parse**: If the data looks like a valid Perl expression (list, hash, etc.), it is evaluated and passed as an array reference.
- **Failed Parse**: If the data is not valid Perl (e.g., `:Attr(qw/unclosed)`), it is passed as a raw string.
- **No Data**: If no parentheses are used (`:Attr`), `undef` is passed.

## Advanced Usage Patterns

### Typed Lexicals
Attributes can be triggered based on the type of a lexical variable, even if the variable is declared in a different package.
```perl
package OtherClass;
my MyModule $obj : MySubAttr; # Triggers MyModule::MySubAttr
```

### Automatic Tying
You can use the module to automatically tie variables to a class when an attribute is present.
```perl
use Attribute::Handlers autotie => { CustomTag => 'Tie::MyClass' };
my $val : CustomTag('initial_params');
```

### Type-Specific Constraints
Limit handlers to specific data types by passing the type to the `:ATTR` declaration:
- `:ATTR(SCALAR)`
- `:ATTR(ARRAY)`
- `:ATTR(HASH)`
- `:ATTR(CODE)`

## Best Practices
- **Phase Awareness**: Remember that handlers typically run during the `CHECK` phase. If you need logic to run at runtime, the handler must arrange for that (e.g., by modifying the subroutine or variable via the `$referent`).
- **Symbol Table Safety**: When dealing with lexicals, `$symbol` will be `'LEXICAL'`. Always check this before attempting to use `*{$symbol}`.
- **Namespace Management**: Since handlers are inherited, ensure attribute names are unique enough to avoid collisions in complex class hierarchies.

## Reference documentation
- [Attribute::Handlers README](./references/github_com_tsee_Attribute-Handlers.md)