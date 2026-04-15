---
name: perl-lwp-mediatypes
description: This tool maps file extensions and URIs to their corresponding MIME types and encodings using the LWP::MediaTypes Perl module. Use when user asks to guess media types from filenames, find file extensions for specific MIME types, or manage custom media type mappings.
homepage: http://metacpan.org/pod/LWP::MediaTypes
metadata:
  docker_image: "quay.io/biocontainers/perl-lwp-mediatypes:6.04--pl526_0"
---

# perl-lwp-mediatypes

## Overview

The `perl-lwp-mediatypes` skill provides methods for handling media types and encodings based on file extensions. It primarily utilizes the `LWP::MediaTypes` Perl module to bridge the gap between filenames/URIs and their corresponding MIME types (e.g., mapping `.html` to `text/html`). This is essential for web-related tasks, file processing pipelines, and automated header generation in HTTP requests or responses.

## Usage Instructions

### Core Functions

The module exports `guess_media_type` by default. Other functions must be requested explicitly.

- **Guessing Media Types**: Use `guess_media_type($file_or_uri)` to return the MIME type string.
- **Finding Extensions**: Use `media_suffix($type)` to find the file extension(s) associated with a MIME type.
- **Custom Mappings**: Use `add_type` or `add_encoding` to define non-standard associations in-memory.

### Command Line One-Liners

Since this is a Perl module, you can use it directly from the CLI for quick checks:

**Guess a file's media type:**
```bash
perl -MLWP::MediaTypes=guess_media_type -E 'say guess_media_type("image.jpg")'
```

**Find the suffix for a MIME type:**
```bash
perl -MLWP::MediaTypes=media_suffix -E 'say media_suffix("application/pdf")'
```

**Check both type and encoding (Array Context):**
```bash
perl -MLWP::MediaTypes=guess_media_type -E '@res = guess_media_type("file.tar.gz"); say "Type: $res[0], Encoding: $res[1]"'
```

### Expert Tips

1.  **URI Objects**: The `guess_media_type` function accepts URI objects. If you are working with the `URI` module, pass the object directly rather than stringifying it first for better compatibility.
2.  **Heuristic Fallback**: If a file extension is unknown, the tool uses the Perl `-T` operator. If the file appears to be text, it returns `text/plain`; otherwise, it defaults to `application/octet-stream`.
3.  **Header Integration**: You can pass an `HTTP::Headers` object as a second argument to `guess_media_type`. The function will automatically populate the `Content-Type` and `Content-Encoding` headers of that object.
4.  **Configuration Files**: The module looks for mappings in `~/.media.types` or `~/.mime.types`. If you need to support custom types across multiple scripts, define them in these files rather than hardcoding `add_type` calls.

## Reference documentation

- [LWP::MediaTypes - guess media type for a file or a URL](./references/metacpan_org_pod_LWP__MediaTypes.md)
- [perl-lwp-mediatypes - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-lwp-mediatypes_overview.md)