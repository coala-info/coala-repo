---
name: lzstring
description: The lzstring tool provides high-efficiency string compression and decompression for Java applications. Use when user asks to compress strings for storage, exchange data between Java and JavaScript, or encode strings into UTF-16 and Base64 formats.
homepage: https://github.com/diogoduailibe/lzstring4j
metadata:
  docker_image: "biocontainers/lzstring:v1.0.4-1-deb-py3_cv1"
---

# lzstring

## Overview
The `lzstring` skill (based on the lzstring4j implementation) provides a mechanism for high-efficiency string compression in Java. It is a port of the original JavaScript LZ-String library, making it the standard choice for cross-platform data exchange where bandwidth or storage space is limited. It excels at compressing repetitive string data into formats that are safe for UTF-16 environments or Base64-encoded transport.

## Implementation Patterns

### Maven Dependency
To use lzstring in a Java project, include the following dependency in your `pom.xml`:

```xml
<dependency>
    <groupId>com.github.diogoduailibe</groupId>
    <artifactId>lzstring4j</artifactId>
    <version>1.3.3</version>
</dependency>
```

### Core Compression Methods
The library provides three primary compression formats. You must use the corresponding decompression method for the specific format used.

#### 1. Standard Compression
Best for general-purpose internal Java string storage.
- **Compress**: `String compressed = LZString.compress("your string");`
- **Decompress**: `String original = LZString.decompress(compressed);`

#### 2. UTF-16 Compression (Web Interoperability)
This is the preferred method for sharing data between a Java server and a JavaScript client. It produces strings that are valid UTF-16, making them safe for browser `localStorage`.
- **Compress**: `String compressed = LZString.compressToUTF16("your string");`
- **Decompress**: `String original = LZString.decompressFromUTF16(compressed);`

#### 3. Base64 Compression
Use this when the compressed string must be sent over a network protocol that requires ASCII-safe characters (e.g., in a URI or a JSON body).
- **Compress**: `String compressed = LZString.compressToBase64("your string");`
- **Decompress**: `String original = LZString.decompressFromBase64(compressed);`

## Expert Tips and Best Practices

- **Interoperability**: When communicating with a JavaScript frontend using the original `lz-string` library, always use the `UTF16` methods. This avoids encoding issues that can occur with standard compression across different language runtimes.
- **Memory Management**: While LZ-String is efficient, compressing extremely large strings in Java can be memory-intensive. For multi-megabyte strings, monitor heap usage.
- **Null Handling**: Ensure input strings are not null before calling compression methods to avoid `NullPointerException`, as the library expects valid string objects.
- **Version Consistency**: This implementation is based on LZString version 1.3.3. Ensure your client-side library is compatible (1.3.x or 1.4.x generally work well together).

## Reference documentation
- [lzstring4j README](./references/github_com_diogoduailibe_lzstring4j.md)