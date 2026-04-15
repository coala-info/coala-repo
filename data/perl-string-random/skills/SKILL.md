---
name: perl-string-random
description: This tool generates random strings based on specific patterns or regular expressions. Use when user asks to generate random passwords, create formatted random strings, or produce random data matching a specific character template.
homepage: http://metacpan.org/release/String-Random
metadata:
  docker_image: "quay.io/biocontainers/perl-string-random:0.30--pl522_0"
---

# perl-string-random

## Overview
The `perl-string-random` tool (based on the `String::Random` Perl module) allows for the generation of random strings that conform to a predefined pattern. Unlike generic random generators, it provides fine-grained control over which character classes appear at specific positions in the output string, making it ideal for tasks requiring formatted random output.

## Usage Instructions

### Pattern Syntax
The core of the tool is the `randpattern` method, which uses a simple shorthand for character classes:

- `c`: Any lowercase alphabetic character [a-z]
- `C`: Any uppercase alphabetic character [A-Z]
- `n`: Any numeric digit [0-9]
- `!`: Any punctuation character
- `a`: Any alphabetic character [a-zA-Z]
- `s`: Any alphanumeric character [a-zA-Z0-9]
- `.`: Any character (the default set includes alphanumeric and punctuation)
- `B`: Any binary digit [01]
- `h`: Any hexadecimal digit [0-9a-f]
- `H`: Any uppercase hexadecimal digit [0-9A-F]

### Common CLI Patterns
Since this is a Perl module, it is most frequently invoked via Perl one-liners for quick string generation:

**Generate a 10-digit random number:**
```bash
perl -MString::Random -e 'print String::Random->new->randpattern("nnnnnnnnnn"), "\n"'
```

**Generate a complex password (e.g., 3 uppercase, 3 lowercase, 2 digits, 2 symbols):**
```bash
perl -MString::Random -e 'print String::Random->new->randpattern("CCCcccnn!!"), "\n"'
```

**Generate a random Hex color code:**
```bash
perl -MString::Random -e 'print "#", String::Random->new->randpattern("HHHHHH"), "\n"'
```

### Using Regular Expressions
For more complex requirements, use the `randregex` method which supports a subset of regular expression syntax (like quantifiers):

```bash
perl -MString::Random -e 'print String::Random->new->randregex('\''[a-z]{5}\d{3}'\''), "\n"'
```

## Best Practices
- **Object Reuse**: If generating many strings in a script, create one `String::Random` object and call methods on it repeatedly rather than initializing a new one for every string.
- **Custom Character Sets**: You can define your own character classes by modifying the `upper`, `lower`, or `digits` attributes of the object if the default sets do not meet your requirements.
- **Escaping**: When using patterns in the shell, always wrap your patterns in single quotes to prevent the shell from interpreting characters like `!` or `$`.

## Reference documentation
- [MetaCPAN String::Random](./references/metacpan_org_release_String-Random.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-string-random_overview.md)