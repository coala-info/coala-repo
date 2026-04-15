---
name: perl-crypt-openssl-rsa
description: This tool provides procedural knowledge for the Crypt::OpenSSL::RSA Perl module to perform secure RSA cryptographic operations. Use when user asks to generate RSA key pairs, encrypt or decrypt data, and manage digital signatures using OpenSSL.
homepage: http://github.com/toddr/Crypt-OpenSSL-RSA
metadata:
  docker_image: "quay.io/biocontainers/perl-crypt-openssl-rsa:0.37--pl5321hc234bb7_0"
---

# perl-crypt-openssl-rsa

## Overview
This skill provides procedural knowledge for the `Crypt::OpenSSL::RSA` Perl module. It enables secure RSA operations by interfacing directly with OpenSSL. Use this skill to generate RSA key pairs, encrypt/decrypt data, and manage digital signatures. Note that as of version 0.35+, insecure PKCS#1 v1.5 padding is disabled; this skill focuses on modern, secure defaults like OAEP for encryption and PSS for signatures.

## Key Management

### Generating Keys
Generate a new RSA key pair (default exponent is 65537).
```perl
use Crypt::OpenSSL::RSA;

# Generate a 2048-bit key
my $rsa = Crypt::OpenSSL::RSA->generate_key(2048);

# Export keys as strings
my $priv_key_str = $rsa->get_private_key_string();
my $pub_key_str = $rsa->get_public_key_x509_string(); # Standard X.509 format
```

### Loading Existing Keys
Load keys from PEM-formatted strings (including headers/footers).
```perl
# Load Public Key
my $rsa_pub = Crypt::OpenSSL::RSA->new_public_key($pub_key_str);

# Load Private Key (with optional passphrase)
my $rsa_priv = Crypt::OpenSSL::RSA->new_private_key($priv_key_str, "your_passphrase");
```

## Encryption and Decryption
The module defaults to **PKCS1_OAEP** padding for encryption.

```perl
# Encryption (using public key)
my $ciphertext = $rsa_pub->encrypt($plaintext);

# Decryption (using private key)
my $decrypted = $rsa_priv->decrypt($ciphertext);
```

## Digital Signatures
For signing, you must explicitly set the padding to **PSS** (PKCS#1 v2.1) for modern security standards.

```perl
# Signing
$rsa_priv->use_pkcs1_pss_padding();
$rsa_priv->use_sha256_hash();
my $signature = $rsa_priv->sign($message);

# Verification
$rsa_pub->use_pkcs1_pss_padding();
$rsa_pub->use_sha256_hash();
if ($rsa_pub->verify($message, $signature)) {
    print "Signature is valid.\n";
}
```

## Expert Tips & Best Practices
- **Error Handling**: Most methods `croak` on failure (e.g., decryption with the wrong key or invalid padding). Always wrap operations in `eval { ... }` or use `Try::Tiny`.
- **Randomness**: If `/dev/random` is unavailable, manually seed the RNG using `Crypt::OpenSSL::Random` before importing the seed into the RSA object.
- **Padding Constraints**: 
    - `PKCS1_OAEP` is for encryption only.
    - `PKCS1_PSS` is for signing only.
    - `PKCS#1 v1.5` is deprecated and will trigger fatal errors in recent versions.
- **Key Formats**: 
    - `get_public_key_string` returns PKCS#1 format (`BEGIN RSA PUBLIC KEY`).
    - `get_public_key_x509_string` returns X.509 format (`BEGIN PUBLIC KEY`), which is generally preferred for interoperability with other tools like `openssl rsa -pubout`.

## Reference documentation
- [Crypt::OpenSSL::RSA GitHub Repository](./references/github_com_cpan-authors_Crypt-OpenSSL-RSA.md)