---
name: perl-lwp-protocol-https
description: This skill enables Perl applications to communicate over secure HTTPS channels.
homepage: https://metacpan.org/pod/LWP::Protocol::https
---

# perl-lwp-protocol-https

## Overview
This skill enables Perl applications to communicate over secure HTTPS channels. By default, the `LWP::UserAgent` module only supports HTTP; installing and configuring `LWP::Protocol::https` acts as a transparent plug-in that allows LWP to handle `https://` schemed URLs. It leverages `IO::Socket::SSL` for the underlying encryption and can be configured to verify hostnames against specific Certificate Authority (CA) bundles.

## Implementation Patterns

### Basic HTTPS Request
To use HTTPS, simply ensure the module is installed. You do not need to `use` it directly in your code; `LWP::UserAgent` will detect it automatically.

```perl
use LWP::UserAgent;

my $ua = LWP::UserAgent->new;
my $response = $ua->get('https://www.example.com');

if ($response->is_success) {
    print $response->decoded_content;
} else {
    die $response->status_line;
}
```

### Configuring SSL Options
You can pass SSL-specific configurations via the `ssl_opts` attribute in the `LWP::UserAgent` constructor.

#### Hostname Verification
It is a best practice to keep `verify_hostname` enabled to prevent man-in-the-middle attacks.

```perl
my $ua = LWP::UserAgent->new(
    ssl_opts => { verify_hostname => 1 }
);
```

#### Custom CA Path
If you are using a private CA or a non-standard certificate store, specify the path to the CA certificates.

```perl
my $ua = LWP::UserAgent->new(
    ssl_opts => {
        SSL_ca_path     => '/etc/ssl/certs',
        verify_hostname => 1,
    }
);
```

### Troubleshooting and Dependencies
*   **Missing Mozilla::CA**: If `verify_hostname` is enabled but no `SSL_ca_file` or `SSL_ca_path` is provided, the module defaults to using `Mozilla::CA`. If this module is missing, HTTPS requests will fail.
*   **Installation**: If the environment lacks HTTPS support, install the module via CPAN or Conda:
    *   CPAN: `cpanm LWP::Protocol::https`
    *   Conda: `conda install bioconda::perl-lwp-protocol-https`

## Reference documentation
- [LWP::Protocol::https - MetaCPAN](./references/metacpan_org_pod_LWP__Protocol__https.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-lwp-protocol-https_overview.md)