---
name: perl-json-pp
description: `perl-json-pp` provides a pure-Perl implementation of a JSON encoder and decoder that is compatible with the high-performance `JSON::XS` module.
homepage: http://metacpan.org/pod/JSON::PP
---

# perl-json-pp

## Overview
`perl-json-pp` provides a pure-Perl implementation of a JSON encoder and decoder that is compatible with the high-performance `JSON::XS` module. It is a core Perl module (since version 5.14) used extensively for parsing metadata and configuration files. This skill provides guidance on using the `json_pp` command-line utility for quick transformations and the Perl API for programmatic data handling, including support for "relaxed" JSON syntax.

## Command-Line Usage (json_pp)
The `json_pp` utility is the primary CLI interface for this package. It reads from STDIN and writes to STDOUT.

### Common CLI Patterns
- **Pretty-print JSON**:
  `cat file.json | json_pp -t json -f json`
- **Validate JSON**:
  `json_pp < file.json > /dev/null` (Returns non-zero exit code on failure)
- **Convert JSON to Perl Data::Dumper format**:
  `json_pp -t dumper < file.json`
- **Handle non-standard JSON**:
  Use the `-json_opt` flag to enable specific parser features:
  `json_pp -json_opt "relaxed,allow_barekey" < file.json`

## Perl API Best Practices
When writing Perl scripts, use `JSON::PP` to ensure portability across systems without C compilers.

### Functional Interface
For standard, UTF-8 encoded JSON, use the exported functions:
- `decode_json($utf8_encoded_binary_string)`: Converts JSON to a Perl hash/array reference.
- `encode_json($perl_reference)`: Converts a Perl structure to a UTF-8 encoded binary string.

### Object-Oriented Interface
Use the OO interface when you need to customize behavior:
- **Human-readable output**: `$json->pretty->encode($data)`
- **7-bit ASCII output**: `$json->ascii->encode($data)` (escapes Unicode characters as `\uXXXX`)
- **Relaxed Parsing**: `$json->relaxed->decode($text)` (allows shell-style comments and trailing commas)
- **Non-standard Keys**: `$json->allow_barekey->decode($text)` or `$json->allow_singlequote->decode($text)`

## Expert Tips
- **Compatibility**: `JSON::PP` is designed to be a fallback for `JSON::XS`. If you use the `JSON` wrapper module, it will automatically prefer `JSON::XS` if installed, falling back to `JSON::PP` otherwise.
- **Boolean Handling**: Use `JSON::PP::true` and `JSON::PP::false` to ensure booleans are correctly represented when encoding to JSON. On Perl 5.36+, standard Perl booleans are supported.
- **Incremental Parsing**: For large streams or network sockets, use the `incr_parse` method to process JSON chunks as they arrive.
- **Security**: Use `max_depth` (default 512) and `max_size` to prevent resource exhaustion attacks when parsing untrusted input.

## Reference documentation
- [JSON::PP - JSON::XS compatible pure-Perl module](./references/metacpan_org_pod_JSON__PP.md)
- [perl-json-pp - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-json-pp_overview.md)