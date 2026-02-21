---
name: perl-text-format
description: The `perl-text-format` tool provides a robust interface for manipulating the layout of plain text.
homepage: http://www.shlomifish.org/open-source/projects/Text-Format
---

# perl-text-format

## Overview
The `perl-text-format` tool provides a robust interface for manipulating the layout of plain text. Unlike simple word-wrappers, it allows for fine-grained control over first-line indentation, hanging indents, and margin constraints. It is particularly useful for cleaning up OCR text, formatting README files, or preparing text-based reports where consistent visual structure is required.

## Usage Patterns

### Basic Paragraph Formatting
To wrap a text file to the default width (usually 72 characters):
```bash
perl -MText::Format -e 'print Text::Format->new->format(<>)' input.txt
```

### Customizing Margins and Indentation
For professional document layouts, use the following attributes:
- **columns**: Sets the maximum line length.
- **firstIndent**: Sets the indentation for the first line of a paragraph.
- **bodyIndent**: Sets the indentation for subsequent lines (useful for bullet points or block quotes).

Example of a block quote format (indented 4 spaces, 60 character width):
```bash
perl -MText::Format -e 'print Text::Format->new({columns => 60, firstIndent => 4, bodyIndent => 4})->format(<>)' input.txt
```

### Handling Multiple Paragraphs
The tool automatically detects double-newlines as paragraph breaks. To ensure headers or lists aren't mangled, ensure there is sufficient whitespace between distinct logical blocks in your source file.

### Expert Tips
- **Right Justification**: Use the `rightFill => 1` option if you require a "block" look where the right margin is aligned (justified), though standard wrapping is usually preferred for readability.
- **Tab Expansion**: Always expand tabs to spaces before processing with this tool to ensure margin calculations remain accurate.
- **Pipe Integration**: This tool is highly effective when used in a shell pipeline to format the output of other text-generating scripts before saving to a final `.txt` or `.md` file.

## Reference documentation
- [Bioconda perl-text-format Overview](./references/anaconda_org_channels_bioconda_packages_perl-text-format_overview.md)