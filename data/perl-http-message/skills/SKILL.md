---
name: perl-http-message
description: The `perl-http-message` library provides a robust base class for representing messages passed in HTTP-style communication.
homepage: https://github.com/libwww-perl/HTTP-Message
---

# perl-http-message

## Overview
The `perl-http-message` library provides a robust base class for representing messages passed in HTTP-style communication. It serves as the foundation for the `HTTP::Request` and `HTTP::Response` classes within the libwww-perl (LWP) ecosystem. This skill enables agents to programmatically construct messages, parse raw HTTP text, and handle the complexities of transport encodings and character set conversions. It is a critical tool for web scraping, API development, and network debugging where fine-grained control over the HTTP lifecycle is required.

## Installation
To install the package using Conda/Bioconda:
```bash
conda install bioconda::perl-http-message
```

## Core Usage Patterns

### Parsing Raw HTTP Messages
You can transform a raw string (e.g., captured from a network socket) into a structured object to easily access headers and body content.

```perl
use HTTP::Message;
my $raw_string = "Content-Type: text/plain\n\nHello World";
my $mess = HTTP::Message->parse($raw_string);

print $mess->header('Content-Type'); # text/plain
print $mess->content;                # Hello World
```

### Handling Compressed Content
One of the most powerful features is the ability to transparently handle compressed payloads (gzip, deflate, brotli).

*   **Decoding:** Use `decoded_content()` to automatically handle `Content-Encoding` and character set decoding.
*   **Encoding:** Use `encode()` to compress the content before transmission.

```perl
# Automatically decompress gzip/deflate and decode charset to Perl Unicode
my $html = $mess->decoded_content;

# Manually compress content
$mess->encode('gzip');
```

### Efficient Content Manipulation
For large payloads, avoid copying strings by using reference-based methods.

```perl
# Get a reference to the content buffer
my $content_ref = $mess->content_ref;

# Modify content in-place using the reference
${$content_ref} =~ s/search_term/replacement/g;
```

### Managing Multipart Messages
`HTTP::Message` can handle composite messages (multipart/*).

```perl
# Access parts of a multipart message
my @parts = $mess->parts;

# Add a new part
$mess->parts([ $part1, $part2 ]);
```

## Expert Tips and Best Practices

*   **Prefer `decoded_content` over `content`:** When dealing with web responses, `content()` returns raw bytes. `decoded_content()` is safer as it handles `Content-Encoding` (like gzip) and `Content-Type` charsets automatically.
*   **Header Normalization:** Use `$mess->headers_as_string("\n")` to get a clean, newline-separated string of all headers for logging or debugging.
*   **Byte Safety:** Remember that `content()` expects and returns strings of bytes. If you are working with Unicode strings in Perl, use `Encode::encode_utf8()` before passing data to `content()`, or use the helper method `add_content_utf8()`.
*   **Commutativity:** Note that `parse()` and `as_string()` are generally commutative, making this library excellent for "man-in-the-middle" style message modification scripts.
*   **Check Decodability:** Use `HTTP::Message::decodable()` to generate a string suitable for the `Accept-Encoding` header in requests, ensuring your client only asks for formats it can actually parse.

## Reference documentation
- [HTTP::Message README and API Documentation](./references/github_com_libwww-perl_HTTP-Message.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-http-message_overview.md)