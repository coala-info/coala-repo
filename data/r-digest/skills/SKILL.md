---
name: r-digest
description: The digest package generates consistent hash digests and message authentication codes for arbitrary R objects and files. Use when user asks to create hash digests of data frames or lists, verify data integrity, implement caching based on object fingerprints, or generate numerically stable SHA-1 hashes for floating-point data.
homepage: https://cloud.r-project.org/web/packages/digest/index.html
---

# r-digest

## Overview
The `digest` package provides a consistent interface for creating hash digests of arbitrary R objects. Unlike standard file-based hashing, `digest()` handles R's internal object serialization, making it possible to hash data frames, lists, and complex models directly. It is widely used for data integrity checks, caching, and identifying changes in datasets.

## Installation
```R
install.packages("digest")
library(digest)
```

## Core Functions

### digest()
The primary function for generating hashes.
```R
# Basic usage (default is md5)
digest(iris)

# Specify algorithm
digest(iris, algo = "sha256")

# Hash a file instead of an object
digest("data.csv", algo = "md5", file = TRUE)
```
**Supported Algorithms:** `md5`, `sha1`, `sha256`, `sha512`, `crc32`, `xxhash32`, `xxhash64`, `murmur32`, `spookyhash`, `blake3`, `xxh3_64`, `xxh3_128`.

### sha1()
A specialized version of SHA-1 designed for numerical stability. It is preferred over `digest(..., algo="sha1")` when dealing with floating-point numbers that might have tiny differences due to hardware architecture (32-bit vs 64-bit) or rounding.
```R
# Numerical stability example
x <- sqrt(2)^2
sha1(2) == sha1(x) # TRUE (handles rounding)
digest(2) == digest(x) # FALSE (exact bitwise comparison)
```

### hmac()
Creates a Hash-based Message Authentication Code.
```R
hmac(key = "secret_key", object = "message_to_sign", algo = "sha256")
```

## Workflows and Best Practices

### 1. Handling Floating Point Sensitivity
When hashing results from statistical models or calculations, use `sha1()` and adjust the `digits` or `zapsmall` arguments to ensure that insignificant numerical noise does not change the hash.
- Use `digits = 14` for raw data.
- Use `digits = 4` for results of floating-point arithmetic (like model coefficients).

### 2. Creating Custom Hash Methods
You can extend `sha1` for custom S3 classes to ensure only relevant components are hashed.
```R
sha1.my_class <- function(x, digits = 14, zapsmall = 7, ..., algo = "sha1") {
    # Extract only the stable parts of the object
    relevant_data <- list(x$data, x$formula)
    sha1(relevant_data, digits = digits, zapsmall = zapsmall, ..., algo = algo)
}
```

### 3. Change Tracking in Analysis
Use hashes to avoid redundant computations:
1. Generate a "fingerprint" of your input data and parameters using `digest()`.
2. Save the result of the analysis using the hash as the filename (e.g., `results_a1b2c3.rds`).
3. Before running an analysis, check if a file with the current input's hash already exists.

## Tips
- **Non-Cryptographic:** This package is optimized for R object comparison and speed. For high-security cryptographic needs, use the `openssl` package.
- **Serialization:** `digest()` uses R's `serialize()` internally. Be aware that changes in R's serialization version (e.g., moving between very old and very new R versions) can theoretically change the hash of the same object.
- **Memory:** For very large objects, `digest` is efficient as it hashes the serialized stream.

## Reference documentation
- [Calculating SHA1 hashes with digest() and sha1()](./references/sha1.md)