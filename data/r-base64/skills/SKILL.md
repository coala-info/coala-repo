---
name: r-base64
description: "Compatibility wrapper to replace the orphaned package. New      applications should use base64 encoders from 'jsonlite' or 'openssl' or     'base64enc'.</p>"
homepage: https://cloud.r-project.org/web/packages/base64/index.html
---

# r-base64

name: r-base64
description: Encode and decode data to/from base64 format in R. Use this skill when working with legacy code requiring the 'base64' package or when needing to convert files to base64 strings for embedding assets (like images) into HTML, Markdown, or JSON.

# r-base64

## Overview
The `base64` package is a compatibility wrapper for base64 encoding and decoding in R. While it is maintained for backward compatibility, it provides a straightforward interface for converting binary files to base64 encoded strings and vice versa. It is particularly useful for embedding images directly into documents.

## Installation
To install the package from CRAN:
```R
install.packages("base64")
```

## Core Functions

### Encoding and Decoding Files
The package primarily works with file paths. If no output path is provided, the functions return a connection or character string.

```R
library(base64)

# Encode a file to base64
base64::encode("input.png", "output.txt")

# Decode a base64 file back to binary
base64::decode("output.txt", "restored.png")
```

### Embedding Images
The `img` function is a helper specifically designed to generate HTML-ready base64 strings from image files.

```R
# Generate a base64 data URI for an image
uri <- base64::img("logo.png")
# Result: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAA..."
```

## Workflows

### Embedding an Image in R Markdown
To programmatically insert a base64 encoded image into an R Markdown document:

```R
```{r, echo=FALSE, results='asis'}
cat(sprintf('<img src="%s" />', base64::img("my_plot.png")))
```
```

### Handling Strings
Since the package is optimized for files, to encode a raw string, you typically write it to a temporary file first or use the underlying `openssl` package which `base64` depends on.

```R
# Using the underlying openssl engine for direct string manipulation
raw_vec <- charToRaw("Hello World")
encoded <- openssl::base64_encode(raw_vec)
decoded <- rawToChar(openssl::base64_decode(encoded))
```

## Usage Tips
- **Compatibility**: This package is a wrapper around `openssl`. For new, high-performance applications, the maintainer recommends using `openssl`, `jsonlite`, or `base64enc` directly.
- **Large Files**: When encoding very large files, ensure you have sufficient disk space for the output, as base64 encoding increases file size by approximately 33%.

## Reference documentation
- [base64: Base64 Encoder and Decoder](./references/home_page.md)