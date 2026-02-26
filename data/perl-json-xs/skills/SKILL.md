---
name: perl-json-xs
description: This tool provides high-performance conversion between Perl data structures and JSON text using a C-based extension. Use when user asks to encode Perl references to JSON, decode JSON strings into Perl structures, or perform fast and strict JSON validation.
homepage: https://metacpan.org/pod/JSON::XS
---


# perl-json-xs

## Overview
The `perl-json-xs` skill provides guidance on using the `JSON::XS` module, a C-based Perl extension designed for maximum performance and correctness. This tool is the industry standard for Perl developers who need to convert between Perl data structures (hashes, arrays, scalars) and JSON text. It excels in scenarios requiring strict JSON validation, binary UTF-8 handling, and low-latency data transformation.

## Functional Interface
For the majority of tasks, use the exported functional interface for simplicity and speed.

- **Encoding**: Convert a Perl reference to a UTF-8 encoded JSON string.
  ```perl
  use JSON::XS;
  my $json_bytes = encode_json($perl_hashref);
  ```
- **Decoding**: Convert a UTF-8 encoded JSON string back into a Perl structure.
  ```perl
  use JSON::XS;
  my $perl_data = decode_json($json_bytes);
  ```

## Object-Oriented Interface
Use the OO interface when you need to customize the output format or behavior.

- **Pretty Printing**: Generate human-readable JSON.
  ```perl
  my $json = JSON::XS->new->pretty->encode($data);
  ```
- **ASCII-only Output**: Escape all non-ASCII characters (useful for 7-bit transports).
  ```perl
  my $json = JSON::XS->new->ascii->encode($data);
  ```
- **Canonical Output**: Sort hash keys to ensure the JSON output is deterministic (useful for checksums/diffs).
  ```perl
  my $json = JSON::XS->new->canonical->encode($data);
  ```

## Best Practices and Expert Tips
- **UTF-8 Handling**: `encode_json` and `decode_json` always expect and produce UTF-8 encoded binary strings (octets). If you are working with Perl's internal "Unicode" strings, use the OO interface with `->encode` and `->decode` without the `utf8` flag, or ensure you manage the encoding layers manually.
- **Speed Optimization**: `JSON::XS` is significantly faster than `JSON::PP` (Pure Perl). In environments where `JSON::XS` is installed, the generic `use JSON;` module will automatically attempt to use `JSON::XS` as the backend.
- **Security**: By default, `JSON::XS` is strict. It will not accept malformed JSON or non-JSON extensions. This makes it safer for parsing untrusted input compared to more "lenient" parsers.
- **Incremental Parsing**: For large streams or network sockets, use the `incr_parse` method to process JSON chunks as they arrive rather than loading the entire string into memory.

## Common CLI Patterns
While primarily a library, `perl-json-xs` is often used in one-liners for quick data manipulation:

- **Validate and Reformat JSON**:
  ```bash
  perl -MJSON::XS -0777 -e 'print JSON::XS->new->pretty->canonical->encode(decode_json(<STDIN>))' < input.json
  ```
- **Extract Data from JSON**:
  ```bash
  perl -MJSON::XS -0777 -e '$d = decode_json(<STDIN>); print $d->{key}' < input.json
  ```

## Reference documentation
- [JSON::XS - JSON serialising/deserialising, done correctly and fast](./references/metacpan_org_pod_JSON__XS.md)
- [perl-json-xs - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-json-xs_overview.md)