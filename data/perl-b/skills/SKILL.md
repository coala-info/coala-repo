---
name: perl-b
description: The perl-b skill manages the specialized build system for the Modern Perl book by weaving documentation fragments into chapters and rendering them into various formats. Use when user asks to weave chapters, generate HTML, ePub, or PDF outputs, or troubleshoot build dependencies for the book.
homepage: https://github.com/chromatic/modern_perl_book
---


# perl-b

## Overview
The perl-b skill provides a specialized workflow for the "Modern Perl" book build system. This system uses a unique "weaving" process where individual documentation fragments (POD) are assembled into cohesive chapters before being rendered into final outputs. Use this skill to ensure the correct sequence of script execution and to troubleshoot dependency requirements for various document formats.

## Environment Requirements
Before running build scripts, ensure the following environment is prepared:
- **Perl Version**: 5.10.1 or newer is recommended (minimum 5.8.6).
- **Core Dependency**: `Pod::PseudoPod` version 0.16 or newer.
- **PDF Dependency**: `App::pod2pdf` must be installed from CPAN to generate PDF output.

## Build Workflow

### 1. Weaving Chapters (Mandatory First Step)
The book's source is modular. You must weave the sections into chapters before generating any final format. This script reads from the `sections/` directory and writes to `build/chapters/`.

```bash
perl build/tools/build_chapters.pl
```

### 2. Generating Output Formats
Once chapters are woven, use the following commands to generate specific formats:

**HTML Output**
Produces formatted HTML in the `build/html/` directory.
```bash
perl build/tools/build_html.pl
```

**ePub eBook**
Produces an ePub file in the `build/epub/` directory.
```bash
perl build/tools/build_epub.pl
```

**PDF Document**
Produces PDF files in the `build/pdf/` directory.
```bash
perl build/tools/build_pdf.pl
```

## Project Structure and Best Practices
- **Source Content**: All raw content resides in the `sections/` directory. Each chapter has a corresponding `chapter_nn.pod` file that acts as a manifest, linking to various section files.
- **Anchors**: The system uses PseudoPod `Z<>` anchors to manage cross-references and weaving points.
- **Clean Builds**: If formatting appears incorrect or links are broken, ensure you have re-run the `build_chapters.pl` script to refresh the intermediate POD files.
- **ActiveState Perl**: For users on ActiveState, an `activestate.yaml` is provided in the root to simplify environment setup and launching.

## Reference documentation
- [Modern Perl Book README](./references/github_com_chromatic_modern_perl_book.md)
- [Modern Perl Book Wiki](./references/github_com_chromatic_modern_perl_book_wiki.md)