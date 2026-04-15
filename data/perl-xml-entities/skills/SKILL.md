---
name: perl-xml-entities
description: This tool decodes and encodes XML entities to convert special characters between XML-compliant formats and standard Unicode. Use when user asks to decode XML entities into readable text, encode special characters for XML safety, or sanitize strings for data processing pipelines.
homepage: http://metacpan.org/pod/XML::Entities
metadata:
  docker_image: "quay.io/biocontainers/perl-xml-entities:1.0002--pl526_0"
---

# perl-xml-entities

## Overview
This skill provides a streamlined way to handle XML entity mapping. While primarily a Perl library, it is frequently used in bioinformatics and data processing pipelines to sanitize strings or prepare text for XML-compliant output. Use this when you encounter "escaped" characters in XML/HTML datasets that need to be converted to standard UTF-8 for analysis, or when you need to ensure special characters are properly encoded for XML compatibility.

## Usage Patterns

### Decoding Entities (XML to Unicode)
To convert XML entities back into readable Unicode characters, use the `decode` function. This is the most common use case when cleaning scraped data or XML exports.

```bash
# Basic one-liner to decode a string
perl -MXML::Entities -e 'print XML::Entities::decode("all", "Data &amp; Analysis &copy; 2024")'
```

### Encoding Entities (Unicode to XML)
To make text XML-safe by converting special characters into entities, use the `encode` function.

```bash
# Encode specific characters for XML safety
perl -MXML::Entities -e 'print XML::Entities::encode("all", "Price < $10 & Quality > 90%")'
```

### Mapping Types
The module supports different mapping sets. Replace `"all"` in the commands above with specific sets if needed:
- `all`: Maps all known entities (default recommended).
- `num`: Maps only to numerical entities.
- `xml`: Maps only the five basic XML entities (`&`, `<`, `>`, `"`, `'`).

## Best Practices
- **Piping Data**: For large files, use Perl's diamond operator to process line-by-line to avoid memory overhead.
  ```bash
  cat input.txt | perl -MXML::Entities -ne 'print XML::Entities::decode("all", $_)'
  ```
- **Character Encoding**: Ensure your shell environment is set to UTF-8 (e.g., `export LANG=en_US.UTF-8`) to correctly display decoded Unicode characters.
- **Bioconda Context**: If using within a Conda environment, ensure the package is installed via `conda install bioconda::perl-xml-entities` before running scripts.

## Reference documentation
- [XML::Entities Documentation](./references/metacpan_org_pod_XML__Entities.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-xml-entities_overview.md)