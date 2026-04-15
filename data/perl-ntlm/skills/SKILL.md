---
name: perl-ntlm
description: This tool provides NTLM authentication support for Perl applications using the Authen::SASL framework. Use when user asks to implement NTLM authentication in Perl, resolve "No SASL mechanism found" errors, or connect to Windows-based mail servers using Net::SMTP.
homepage: https://github.com/stevenl/Authen-SASL-Perl-NTLM
metadata:
  docker_image: "quay.io/biocontainers/perl-ntlm:1.09--pl526_3"
---

# perl-ntlm

## Overview

The `perl-ntlm` skill provides procedural knowledge for implementing NTLM (NT LAN Manager) authentication within the Perl `Authen::SASL` ecosystem. This module acts as a plugin that allows Perl clients to negotiate NTLM challenges. It is the primary solution for the common "No SASL mechanism found" error encountered when attempting to connect to Windows-based mail servers that mandate NTLM authentication.

## Implementation Patterns

### Basic Client Setup
To use NTLM authentication, you must explicitly load `Authen::SASL` with the `Perl` implementation and specify the `NTLM` mechanism.

```perl
use Authen::SASL qw(Perl);

my $sasl = Authen::SASL->new(
    mechanism => 'NTLM',
    callback  => {
        user => $username,
        pass => $password,
    },
);
```

### Handling Windows Domains
NTLM often requires a domain. You can specify the domain by prefixing the username using the standard Windows format. Note the requirement for double backslashes in Perl strings to escape the character.

```perl
callback => {
    user => "DOMAIN\\username",
    pass => 'your_password',
},
```

### Integration with Net::SMTP
This is the most common use case. When `Net::SMTP` attempts to authenticate, it uses `Authen::SASL` internally.

```perl
use Net::SMTP;
use Authen::SASL qw(Perl);

my $smtp = Net::SMTP->new('mail.example.com');
$smtp->auth($sasl); # Pass the SASL object created above
```

## Troubleshooting and Best Practices

### Resolving "No SASL mechanism found"
If you receive this error while trying to use NTLM, it usually means `Authen::SASL::Perl::NTLM` is not installed or not correctly loaded. 
1. Ensure the module is installed via CPAN: `cpan Authen::SASL::Perl::NTLM`.
2. Verify that you are using `use Authen::SASL qw(Perl);` to ensure the pure-Perl search path for plugins is active.

### Debugging the Challenge/Response
If authentication fails, you can manually step through the SASL process to inspect the tokens:

```perl
my $client = $sasl->client_new('smtp', 'localhost');
my $initial_response = $client->client_start();
# Send $initial_response to server, get $challenge back
my $auth_response = $client->client_step($challenge);
```

### Limitations
- **Client-Side Only**: This module only implements the client side of the NTLM handshake. It cannot be used to build an NTLM-authenticating server.
- **Dependencies**: This module depends on `Authen::NTLM`. Ensure that underlying system libraries for NTLM are not required, as this is a Perl-level implementation.

## Reference documentation
- [Authen::SASL::Perl::NTLM README](./references/github_com_stevenl_Authen-SASL-Perl-NTLM.md)