---
name: perl-mozilla-ca
description: The `perl-mozilla-ca` skill provides the procedural knowledge to integrate Mozilla's trusted CA certificate bundle into Perl environments.
homepage: https://metacpan.org/pod/Mozilla::CA
---

# perl-mozilla-ca

## Overview

The `perl-mozilla-ca` skill provides the procedural knowledge to integrate Mozilla's trusted CA certificate bundle into Perl environments. This module is the standard way to ensure that Perl scripts can verify the identity of remote servers (like HTTPS websites) using the same root certificates trusted by the Firefox browser. It is particularly useful in isolated environments (like Conda environments or containers) where system-level certificates might not be correctly configured.

## Usage Patterns

### Integration with IO::Socket::SSL
The most common use case is providing the certificate path to `IO::Socket::SSL`, which underlies most Perl networking modules.

```perl
use IO::Socket::SSL;
use Mozilla::CA;

my $client = IO::Socket::SSL->new(
    PeerHost        => "api.example.com:443",
    SSL_verify_mode => SSL_VERIFY_PEER,
    # Use the helper function to get the absolute path to the PEM file
    SSL_ca_file     => Mozilla::CA::SSL_ca_file(),
) or die "Connection failed: $SSL_ERROR";
```

### Integration with LWP::UserAgent
To make `LWP` use this bundle for all requests:

```perl
use LWP::UserAgent;
use Mozilla::CA;

my $ua = LWP::UserAgent->new;
$ua->ssl_opts(
    verify_hostname => 1,
    SSL_ca_file     => Mozilla::CA::SSL_ca_file(),
);
```

### Environment Variable Override
If you cannot modify the source code of a Perl script but need it to use the Mozilla CA bundle, you can often set the `HTTPS_CA_FILE` environment variable (supported by `Crypt::SSLeay` and some versions of `LWP`):

```bash
export HTTPS_CA_FILE=$(perl -MMozilla::CA -e 'print Mozilla::CA::SSL_ca_file()')
perl your_script.pl
```

## Installation Best Practices

### Conda/Bioconda
In bioinformatics or data science workflows, install via bioconda to ensure dependencies are handled within the environment:
```bash
conda install -c bioconda perl-mozilla-ca
```

### CPAN
For standard Perl environments:
```bash
cpanm Mozilla::CA
```

## Expert Tips
- **Absolute Paths**: Always use `Mozilla::CA::SSL_ca_file()` instead of hardcoding paths. The location of the `.pem` file changes depending on the installation prefix (e.g., `/usr/local` vs. a Conda env).
- **Verification Mode**: Simply providing the `SSL_ca_file` is often not enough; ensure `SSL_verify_mode` is set to a value that actually performs verification (typically `0x02` or `SSL_VERIFY_PEER`).
- **Updating**: Root certificates expire or are revoked. Regularly update the `perl-mozilla-ca` package to ensure your application trusts the current set of Certificate Authorities.

## Reference documentation
- [Mozilla::CA - Metacpan](./references/metacpan_org_pod_Mozilla__CA.md)
- [Bioconda perl-mozilla-ca Overview](./references/anaconda_org_channels_bioconda_packages_perl-mozilla-ca_overview.md)