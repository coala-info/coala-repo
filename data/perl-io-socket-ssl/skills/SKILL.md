---
name: perl-io-socket-ssl
description: This Perl module provides a transparent SSL/TLS encryption layer for network applications by acting as a drop-in replacement for IO::Socket::INET. Use when user asks to integrate SSL/TLS security into Perl scripts, create secure client-server connections, or handle certificate validation and encrypted handshakes.
homepage: https://github.com/noxxi/p5-io-socket-ssl
metadata:
  docker_image: "quay.io/biocontainers/perl-io-socket-ssl:2.074--pl5321hdfd78af_0"
---

# perl-io-socket-ssl

## Overview
IO::Socket::SSL is the industry-standard Perl module for integrating SSL/TLS security into network applications. It acts as a drop-in replacement for IO::Socket::INET, providing a transparent encryption layer. It handles the complexities of the SSL handshake, cipher negotiation, and certificate validation while maintaining a familiar object-oriented interface. This skill covers installation, secure configuration patterns, and common implementation pitfalls.

## Installation
The module can be installed via system package managers or Perl-specific tools:

- **Conda (Bioconda):** `conda install bioconda::perl-io-socket-ssl`
- **CPAN:** `perl -MCPAN -e 'install IO::Socket::SSL'`
- **Manual:**
  ```bash
  perl Makefile.PL
  make
  make test
  make install
  ```

## Core Usage Patterns

### Basic Secure Client
To create a secure connection to a remote host:
```perl
use IO::Socket::SSL;

my $client = IO::Socket::SSL->new(
    PeerHost => "www.example.com",
    PeerPort => 443,
    SSL_verify_mode => SSL_VERIFY_PEER,
) or die "failed connect or ssl handshake: $!, $SSL_ERROR";

print $client "GET / HTTP/1.0\r\n\r\n";
print <$client>;
```

### Basic Secure Server
To listen for incoming encrypted connections:
```perl
use IO::Socket::SSL;

my $server = IO::Socket::SSL->new(
    LocalAddr => '0.0.0.0',
    LocalPort => 443,
    Listen => 10,
    SSL_cert_file => 'server-cert.pem',
    SSL_key_file => 'server-key.pem',
) or die "failed to listen: $!, $SSL_ERROR";

while (my $client = $server->accept) {
    print $client "Welcome to the secure server\n";
    close $client;
}
```

## Expert Tips and Best Practices

### Certificate Verification
Never use `SSL_VERIFY_NONE` in production. Always verify the peer certificate to prevent Man-in-the-Middle (MitM) attacks.
- **Default Behavior:** Modern versions of IO::Socket::SSL enable `SSL_VERIFY_PEER` by default.
- **Custom CA:** If using a private CA, specify it using `SSL_ca_file` or `SSL_ca_path`.

### Handling Handshake Failures
If a connection fails, check `$SSL_ERROR` (exported by the module) rather than just `$!`. `$SSL_ERROR` contains specific details about certificate expiration, hostname mismatches, or protocol incompatibilities.

### Fingerprinting
For high-security environments where you want to pin a specific certificate, use the fingerprinting options:
- `SSL_fingerprint`: Verify the certificate against a specific SHA-256 or SHA-1 hash.
- `SSL_force_fingerprint`: Use this to enforce fingerprint checks even if other verification steps pass.

### Perfect Forward Secrecy (PFS)
To support PFS, ensure `Net::SSLeay` v1.56 or newer is installed. This allows the use of ECDH curves. The module typically selects the best available ciphers automatically, but you can restrict them using `SSL_cipher_list`.

### OCSP and Revocation
To check for revoked certificates using OCSP, ensure you have OpenSSL 1.0.0+ and `Net::SSLeay` 1.59+. Use the `SSL_ocsp_mode` parameter to configure stapling or direct requests.

## Troubleshooting
- **Random Number Generator (RNG):** On older systems (like Solaris), the module may fail if no RNG is found. Install `egd` (Entropy Gathering Daemon) or set the `SKIP_RNG_TEST` environment variable if you are certain an RNG is available but not detected.
- **Dependencies:** Ensure `Net::SSLeay` is up to date, as IO::Socket::SSL is a wrapper around it. Many protocol-level features (like TLS 1.3) depend on the underlying OpenSSL version linked to `Net::SSLeay`.

## Reference documentation
- [perl-io-socket-ssl - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-io-socket-ssl_overview.md)
- [GitHub - noxxi/p5-io-socket-ssl: IO::Socket::SSL Perl Module](./references/github_com_noxxi_p5-io-socket-ssl.md)