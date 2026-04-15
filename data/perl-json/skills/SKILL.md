---
name: perl-json
description: This tool converts between Perl data structures and JSON strings using functional or object-oriented interfaces. Use when user asks to encode Perl references to JSON, decode JSON strings into Perl, or format JSON output with specific configurations like pretty-printing.
homepage: http://metacpan.org/pod/JSON
metadata:
  docker_image: "quay.io/biocontainers/perl-json:4.10--pl5321hdfd78af_1"
---

# perl-json

## Overview
The `perl-json` skill facilitates the conversion between Perl data structures and JSON strings. It utilizes the `JSON` module (often a wrapper for `JSON::XS` or `JSON::PP`), providing a high-performance functional interface for standard tasks and a feature-rich object-oriented interface for customized formatting, encoding requirements, and "relaxed" parsing.

## Functional Interface
For simple, fast conversions using UTF-8 encoding, use the functional interface.

- **encode_json**: Converts a Perl reference to a UTF-8 encoded JSON string.
  ```perl
  use JSON;
  my $json_text = encode_json($perl_scalar);
  ```
- **decode_json**: Converts a UTF-8 encoded JSON string back into a Perl reference.
  ```perl
  my $perl_scalar = decode_json($json_text);
  ```

## Object-Oriented Interface
Use the OO interface when you need specific formatting or behavior (e.g., pretty-printing, non-UTF-8 output, or allowing comments).

```perl
use JSON;
my $json = JSON->new->ascii->pretty->allow_nonref;

$json_text = $json->encode($perl_scalar);
$perl_scalar = $json->decode($json_text);
```

### Common Configuration Methods
- `ascii([$enable])`: If enabled, uses `\uXXXX` escapes for non-ASCII characters.
- `pretty([$enable])`: Enables `indent`, `space_before`, and `space_after` for human-readable output.
- `relaxed([$enable])`: Allows the parser to accept trailing commas and shell-style (#) comments.
- `canonical([$enable])`: Sorts hash keys alphabetically for deterministic output.
- `utf8([$enable])`: Ensures the output is UTF-8 encoded (default for `encode_json`).

## CLI One-liner Patterns
The `perl-json` module is frequently used for quick JSON manipulation directly from the shell.

**Pretty-print a JSON file:**
```bash
cat data.json | perl -MJSON -0777 -ne 'print JSON->new->pretty->encode(decode_json($_))'
```

**Extract a specific key from a JSON object:**
```bash
curl -s https://api.example.com/data | perl -MJSON -0777 -ne '$d = decode_json($_); print $d->{target_key}'
```

**Convert a Perl-style list to JSON:**
```bash
perl -MJSON -e 'print encode_json([1, 2, {a => 3}])'
```

## Expert Tips
- **Backend Selection**: The `JSON` module automatically attempts to use `JSON::XS` for speed, falling back to `JSON::PP` (pure perl) if the C-based module is unavailable.
- **Boolean Handling**: Use `JSON::true` and `JSON::false` to represent JSON booleans in Perl structures, or check them using `JSON::is_bool($value)`.
- **Incremental Parsing**: For large streams, consider using `JSON->new->incr_parse` to process chunks of data as they arrive.
- **Security**: When parsing untrusted input, avoid using `relaxed` unless necessary, as it deviates from the strict JSON specification.

## Reference documentation
- [JSON - JSON (JavaScript Object Notation) encoder/decoder](./references/metacpan_org_pod_JSON.md)
- [perl-json - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-json_overview.md)