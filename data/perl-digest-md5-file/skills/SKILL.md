---
name: perl-digest-md5-file
description: This tool calculates MD5 checksums for local files and remote URLs. Use when user asks to calculate file digests, verify the integrity of remote data via URL, or generate MD5 hashes for large datasets.
homepage: http://search.cpan.org/dist/Digest-MD5-File/
metadata:
  docker_image: "quay.io/biocontainers/perl-digest-md5-file:0.08--pl5.22.0_0"
---

# perl-digest-md5-file

## Overview
The `perl-digest-md5-file` tool extends the standard MD5 capabilities to handle file paths and URLs directly. It is particularly useful in bioinformatics pipelines (bioconda) and web-scraping workflows where verifying the integrity of downloaded data or local datasets is a critical step. Unlike standard `md5sum` utilities, this tool can fetch and hash remote content in a single operation.

## Usage Patterns

### Basic File Checksum
To get the MD5 hex digest of a local file:
```perl
use Digest::MD5::File qw(file_md5_hex);

my $digest = file_md5_hex($path_to_file);
print "MD5: $digest\n";
```

### Remote URL Checksum
To calculate the MD5 sum of a file hosted on a web server without manually downloading it first:
```perl
use Digest::MD5::File qw(url_md5_hex);

my $url = 'http://example.com/data.tar.gz';
my $digest = url_md5_hex($url);
print "Remote MD5: $digest\n";
```

### Handling Large Files
For memory efficiency with large files, use the object-oriented approach to process data in chunks:
```perl
use Digest::MD5::File;

my $ctx = Digest::MD5::File->new;
$ctx->addfile($path_to_large_file);
my $digest = $ctx->hexdigest;
```

## Expert Tips
- **Error Handling**: When using `url_md5_hex`, always wrap the call in an `eval` block or check for defined results, as network timeouts or 404 errors will cause the operation to fail.
- **Bioconda Environment**: If using via Conda, ensure the environment is activated (`conda activate bioconda`) to make the Perl libraries available to your scripts.
- **Protocol Support**: The URL functionality typically supports HTTP and FTP protocols as provided by the underlying LWP (Library for WWW in Perl) modules.

## Reference documentation
- [Digest-MD5-File Release Info](./references/metacpan_org_release_Digest-MD5-File.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-digest-md5-file_overview.md)