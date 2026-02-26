---
name: perl-encode
description: This tool manages character encodings by translating between raw bytes and Perl strings using the Encode module and the piconv utility. Use when user asks to convert file encodings, list supported character sets, or handle character encoding and decoding within Perl scripts.
homepage: http://metacpan.org/pod/Encode
---


# perl-encode

## Overview
The `perl-encode` skill provides the procedural knowledge required to manage character encodings using the Perl `Encode` module and its associated utility, `piconv`. It facilitates the translation between "octets" (raw bytes) and "strings" (decoded characters). This skill is critical for avoiding "mojibake" (character corruption) and ensuring that data pipelines correctly handle international text.

## CLI Usage: piconv
The `piconv` (Perl Iconv) utility is the standard command-line interface for the Encode module.

### Basic Conversion
Convert a file from one encoding to another and output to STDOUT:
```bash
piconv -f shiftjis -t utf8 input.txt
```

### List Supported Encodings
To see all available encoding names supported by the current installation:
```bash
piconv -l
```

### Resolve Encoding Issues
If a conversion fails or produces unexpected results, use the `-s` flag to suppress errors or check for valid byte sequences:
```bash
piconv -s -f utf8 -t ascii input.txt
```

## Perl API Best Practices
When writing Perl scripts that utilize `Encode`, follow the "Decode Early, Encode Late" philosophy.

### Core Functions
Always use `decode` to bring data into Perl's internal format and `encode` to send it out.
```perl
use Encode qw(encode decode);

# Convert raw bytes from a file/socket into a Perl string
my $string = decode("UTF-8", $octets);

# Convert a Perl string into raw bytes for output
my $octets = encode("UTF-8", $string);
```

### Handling Filehandles
Instead of manual encoding/decoding, apply the encoding layer directly to the filehandle to automate the process.
```perl
# Reading a UTF-8 file
open(my $fh, "<:encoding(UTF-8)", "file.txt") or die $!;

# Writing to a legacy encoding
open(my $out, ">:encoding(iso-8859-1)", "output.txt") or die $!;
```

### Error Handling (Check Values)
Use the third argument of `encode`/`decode` to define behavior when encountering malformed data:
- `Encode::FB_CROAK`: Die on error (best for data integrity).
- `Encode::FB_QUIET`: Stop processing at the first error and leave the remainder in the source.
- `Encode::FB_WARN`: Warn but continue.

```perl
my $octets = encode("ascii", $string, Encode::FB_CROAK);
```

## Expert Tips
- **Internal vs. External**: Never perform string operations (like `length` or `substr`) on raw octets. Always `decode` first.
- **UTF-8 vs utf8**: In Perl, `UTF-8` (with a dash) is the strict, standard-compliant encoding. `utf8` (no dash) is Perl's internal, more relaxed representation. Use `UTF-8` for data exchange.
- **Double Encoding**: If text looks like `Ã©`, it has likely been double-encoded as UTF-8. Ensure you are not calling `encode` on a string that is already in octet form.

## Reference documentation
- [Encode - character encodings in Perl](./references/metacpan_org_pod_Encode.md)
- [perl-encode - bioconda overview](./references/anaconda_org_channels_bioconda_packages_perl-encode_overview.md)