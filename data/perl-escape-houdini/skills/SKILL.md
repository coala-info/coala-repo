---
name: perl-escape-houdini
description: The `perl-escape-houdini` skill provides procedural knowledge for using the `Escape::Houdini` Perl module.
homepage: https://github.com/yanick/Escape-Houdini
---

# perl-escape-houdini

## Overview

The `perl-escape-houdini` skill provides procedural knowledge for using the `Escape::Houdini` Perl module. This tool acts as a wrapper for the Houdini C library, offering a zero-dependency, minimalistic, and extremely fast solution for web escaping tasks. It is ideal for bioinformatics pipelines or data processing scripts that require high-throughput text sanitization before generating web reports, XML files, or URI-encoded strings.

## Installation

In environments where Bioconda is available, install the package using:

```bash
conda install bioconda::perl-escape-houdini
```

## Usage Patterns

### Function Imports
The module does not export functions by default. Use export tags to load specific groups of functions efficiently:

- `:all` - Imports every available function.
- `:html` - Imports `escape_html` and `unescape_html`.
- `:uri` - Imports `escape_uri` and `unescape_uri`.
- `:url` - Imports `escape_url` and `unescape_url`.
- `:js` - Imports `escape_js` and `unescape_js`.

### Common Code Snippets

**HTML Sanitization**
```perl
use Escape::Houdini 'escape_html';
my $raw_input = '<script>alert("xss")</script>';
my $safe_html = escape_html($raw_input); 
# Result: &lt;script&gt;alert(&quot;xss&quot;)&lt;/script&gt;
```

**URL Encoding**
```perl
use Escape::Houdini 'escape_url';
my $url = "https://example.com/search?q=perl & houdini";
my $encoded = escape_url($url);
# Result: https%3A%2F%2Fexample.com%2Fsearch%3Fq%3Dperl%20%26%20houdini
```

**JavaScript Escaping**
```perl
use Escape::Houdini 'escape_js';
my $js_string = "window.location = 'http://site.com';\n";
my $escaped_js = escape_js($js_string);
# Result: window.location = \'http:\/\/site.com\';\n
```

## Expert Tips and Best Practices

1.  **Performance Advantage**: Prefer `Escape::Houdini` over pure-Perl modules like `HTML::Entities` when processing large datasets (e.g., millions of sequences or metadata entries), as the underlying C library is optimized for speed.
2.  **UTF-8 Handling**: Recent versions (0.3.2+) automatically set the UTF-8 flag on returned values. Ensure your Perl script handles encoding correctly (e.g., `use utf8;`) to maintain consistency when processing multi-byte characters.
3.  **XML vs. HTML**: Use `escape_xml` specifically when generating XML documents to ensure compliance with XML-specific entity requirements, which can differ slightly from standard HTML5 escaping.
4.  **HREF Context**: Use `escape_href` when you are specifically placing a string inside an `href` or `src` attribute, as it applies logic tailored for attribute-level safety.

## Reference documentation
- [Bioconda perl-escape-houdini Overview](./references/anaconda_org_channels_bioconda_packages_perl-escape-houdini_overview.md)
- [Escape::Houdini GitHub Repository](./references/github_com_yanick_Escape-Houdini.md)