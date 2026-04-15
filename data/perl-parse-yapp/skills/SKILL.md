---
name: perl-parse-yapp
description: This tool generates LALR parsers for Perl by compiling context-free grammar files into standalone modules or scripts. Use when user asks to build a custom parser, define a context-free grammar in a .yp file, or resolve shift/reduce conflicts in a Perl-based language processor.
homepage: http://metacpan.org/pod/Parse::Yapp
metadata:
  docker_image: "quay.io/biocontainers/perl-parse-yapp:1.21--pl526_0"
---

# perl-parse-yapp

## Overview
This skill facilitates the development of custom parsers within the Perl ecosystem. Parse::Yapp (Yet Another Perl Parser) provides a Yacc-like environment for defining context-free grammars. It is particularly useful for building thread-safe, object-oriented parsers where the grammar is defined in a `.yp` file and compiled into a standalone Perl module. Use this when you need to move beyond simple regular expressions for complex data extraction or domain-specific language (DSL) interpretation.

## Grammar File Structure (.yp)
Grammar files are divided into three sections separated by `%%`.

1.  **Header Section**: Contains `%left`, `%right`, `%nonassoc` for precedence, and `%start` to define the entry point. Use `%{ ... %}` for verbatim Perl code (imports/globals).
2.  **Rules Section**: Defines the EBNF-like grammar rules.
3.  **Footer Section**: Contains the lexer (`yylex`) and error reporting (`yyerror`) subroutines.

## CLI Usage Patterns
The `yapp` frontend converts the grammar into a Perl module.

- **Generate a module**:
  `yapp -m Your::Module::Name grammar.yp > Name.pm`
- **Generate a standalone parser script** (includes a default driver):
  `yapp -s grammar.yp`
- **Check for conflicts**:
  `yapp -v grammar.yp`
  This creates `grammar.output`, which is essential for debugging Shift/Reduce or Reduce/Reduce conflicts.

## Expert Implementation Tips

### Reentrant Semantic Actions
In Parse::Yapp, the first argument to any action block (`$_[0]`) is the parser object itself. Use this to maintain state without global variables:
```perl
exp: NUM { $_[0]->YYData->{COUNT}++; $_[1] }
```

### Writing the Lexer
The lexer must be a subroutine returning a list of `(TOKEN_NAME, VALUE)`. Return `('', undef)` at End-of-File.
```perl
sub _Lexer {
    my($parser)=shift;
    $parser->YYData->{INPUT} =~ s/^[ \t\n]+//; # Skip whitespace
    return('',undef) if $parser->YYData->{INPUT} eq '';
    # Token logic here...
}
```

### Error Recovery
Use the built-in methods within your `yyerror` sub or semantic actions:
- `$_[0]->YYErrok`: Resume parsing after an error.
- `$_[0]->YYExpect`: Returns a list of tokens the parser was expecting.
- `$_[0]->YYCurtok`: Returns the token that caused the failure.

### Precedence Handling
To resolve "dangling else" or unary minus issues, use `%prec`:
```perl
exp: '-' exp %prec NEG { -$_[2] }
```

## Reference documentation
- [Parse::Yapp - Perl extension for generating and using LALR parsers](./references/metacpan_org_pod_Parse__Yapp.md)
- [perl-parse-yapp Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_perl-parse-yapp_overview.md)