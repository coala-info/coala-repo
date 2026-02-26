---
name: perl-text-template-simple
description: This tool provides a high-performance templating engine that embeds native Perl logic and expressions into static text files. Use when user asks to generate dynamic reports, automate boilerplate code creation, or process text templates using Perl flow control.
homepage: http://metacpan.org/pod/Text::Template::Simple
---


# perl-text-template-simple

## Overview
This skill provides guidance on using the `Text::Template::Simple` engine to bridge static text with dynamic Perl logic. It is designed for scenarios requiring high-performance templating where the template syntax remains close to native Perl. Use this tool to automate the generation of repetitive text structures, such as boilerplate code, reports, or web content, by embedding Perl expressions and flow control directly into your source files.

## Core Usage Patterns

### Template Syntax
The engine uses specific delimiters to identify Perl code within text:
- `<% ... %>`: Execute Perl code (e.g., loops, variable assignments).
- `<%= ... %>`: Execute Perl code and include the result in the output.
- `<%# ... %>`: Comments (ignored by the engine).

### Command Line Execution
While primarily a library, it is often invoked via Perl one-liners or wrapper scripts in pipeline environments:

```bash
# Basic one-liner to process a template with a data provider
perl -MText::Template::Simple -e 'print Text::Template::Simple->new->compile("template.txt", { var => "value" })'
```

### Best Practices
- **Keep Logic Minimal**: Perform heavy data processing in a separate Perl script and pass only the final result set to the template.
- **Delimiter Safety**: If your text contains `<%` or `%>` naturally, ensure you escape them or use the `header` and `footer` options in the constructor to change the delimiters.
- **Caching**: For repetitive tasks, use the `cache` option in the `new()` constructor to improve performance by avoiding recompilation of the same template.

## Advanced Configuration
When initializing the engine, consider these parameters for better control:
- `path`: Define a search path for included templates.
- `safe`: Enable a Safe compartment to restrict the Perl code allowed within the template (recommended for untrusted templates).
- `strict`: Enforce `use strict` within the template code to catch variable errors.

## Reference documentation
- [Text::Template::Simple Documentation](./references/metacpan_org_pod_Text__Template__Simple.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-text-template-simple_overview.md)