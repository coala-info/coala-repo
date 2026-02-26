---
name: lxml
description: lxml provides a high-performance Pythonic interface for parsing, manipulating, and validating XML and HTML documents using the libxml2 and libxslt C libraries. Use when user asks to parse large XML files, perform XPath queries, execute XSLT transformations, sanitize HTML, or generate XML documents incrementally.
homepage: https://github.com/lxml/lxml
---


# lxml

## Overview

The `lxml` skill provides a robust interface for the `libxml2` and `libxslt` C libraries, offering a Pythonic API that balances ease of use with extreme performance. It is the preferred tool for complex XML tasks such as XPath queries, XSLT transformations, and schema validation (DTD, XML Schema, RelaxNG). This skill focuses on leveraging `lxml` for efficient data extraction, document modification, and secure handling of external entities and compressed inputs.

## Core Usage and Best Practices

### High-Performance Parsing
For standard parsing, use the `etree` or `html` modules. To optimize for memory when dealing with large files, prefer incremental parsing.

*   **Standard Parse:** `tree = etree.parse(source)` or `root = etree.fromstring(xml_string)`.
*   **Zero-Copy Parsing:** As of version 6.0.0, `lxml` supports parsing from `memoryview` and other buffers to allow zero-copy operations.
*   **Large Files:** Use `etree.iterparse()` to iterate through elements without loading the entire tree into memory. Always clear elements after processing:
    ```python
    for event, elem in etree.iterparse(source, events=("end",)):
        # process(elem)
        elem.clear()
        while elem.getprevious() is not None:
            del elem.getparent()[0]
    ```

### Security and Decompression Bombs
When handling untrusted input, security is paramount.
*   **Decompression Control:** Use the `decompress=False` parser option (available for libxml2 2.15.0+) to prevent decompression bombs.
*   **External Entities:** By default, `lxml` does not resolve external entities. Ensure `resolve_entities=False` is set in your parser if you are handling untrusted XML to prevent XXE attacks.

### HTML Manipulation and Diffing
`lxml.html` provides specialized tools for web data.
*   **Cleaning HTML:** Use `lxml.html.clean.Cleaner` to sanitize HTML, though be aware of specific security advisories regarding SVG embedded scripts.
*   **Structural Diffs:** Use `lxml.html.diff.htmldiff(old_html, new_html)` for high-quality, structurally aware differences between two HTML fragments.
*   **Tag Handling:** Access `head` and `body` properties directly on HTML elements; they return `None` if the element is missing rather than raising an exception.

### Incremental Writing
For generating large XML files efficiently, use the `xmlfile()` context manager:
```python
with etree.xmlfile("output.xml", encoding="utf-8") as xf:
    with xf.element("root"):
        xf.write(etree.Element("child"))
        xf.write(etree.CDATA("special content")) # Supported in v6.0.0+
```

### Expert Tips
*   **Feature Detection:** Check available library features at runtime using `etree.LIBXML_FEATURES` (e.g., check for `"zlib"`, `"xpath"`, or `"icu"`).
*   **Type Hinting:** In modern versions (6.0.0+), `Element` and `ElementTree` factories can be used directly in type hints.
*   **Smart Strings:** Be aware that `.text_content()` on HTML elements returns plain strings in recent versions, removing previous "smart string" metadata that could cause unexpected behavior in some contexts.

## Reference documentation
- [What is lxml?](./references/github_com_lxml_lxml.md)
- [New Features and Bug Fixes in 6.0.0](./references/github_com_lxml_lxml_tags.md)
- [Security Policy and Advisories](./references/github_com_lxml_lxml_security.md)