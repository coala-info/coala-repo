---
name: perl-authen-sasl-saslprep
description: This skill provides guidance on using the `Authen::SASL::SASLprep` Perl module to normalize strings used in authentication.
homepage: http://metacpan.org/pod/Authen-SASL-SASLprep
---

# perl-authen-sasl-saslprep

## Overview
This skill provides guidance on using the `Authen::SASL::SASLprep` Perl module to normalize strings used in authentication. SASLprep is a standard process that handles Unicode normalization, mapping of "unassigned" or "prohibited" characters, and bidirectional character handling. It is essential for developers and system administrators who need to ensure that credentials entered on one system (e.g., a web form) match those stored in a directory or database (e.g., LDAP) regardless of minor encoding variations.

## Usage Patterns

### Basic String Normalization
The primary function is `saslprep`, which takes a raw string and returns the normalized version.

```perl
use Authen::SASL::SASLprep;

my $input = "User\x{00A0}Name"; # Contains a non-breaking space
my $output = saslprep($input);
# $output now contains "User Name" (normalized space)
```

### Handling Passwords
When processing passwords, always apply `saslprep` before hashing or comparing values to prevent authentication failures caused by different Unicode representations of the same character.

```perl
my $normalized_password = saslprep($raw_password);
# Proceed with authentication using $normalized_password
```

### Error Handling
The `saslprep` function will `die` (throw an exception) if the input string contains prohibited characters (as defined by RFC 4013) or if the string is not valid UTF-8. Wrap calls in an `eval` block or use a Try/Catch module for robust implementation.

```perl
my $safe_string;
eval {
    $safe_string = saslprep($user_input);
};
if ($@) {
    # Handle invalid input (e.g., prohibited characters found)
    warn "Invalid characters in input: $@";
}
```

## Best Practices
- **Input Encoding**: Ensure strings are decoded into Perl's internal Unicode format before passing them to `saslprep`.
- **Consistency**: Apply SASLprep at both the point of registration (storage) and the point of authentication (verification).
- **Scope**: Use this specifically for SASL-related strings (usernames/passwords). For general domain name normalization, use Nameprep or IDNA instead.

## Reference documentation
- [Authen::SASL::SASLprep Documentation](./references/metacpan_org_pod_Authen-SASL-SASLprep.md)