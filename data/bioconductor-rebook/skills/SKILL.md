---
name: bioconductor-rebook
description: The rebook package provides a framework for modularizing Bioconductor books by enabling object reuse between chapters and linking across different book packages. Use when user asks to reuse objects from other Rmarkdown files, link to specific sections in other Bioconductor books, or manage dependencies and styling for book development.
homepage: https://bioconductor.org/packages/release/bioc/html/rebook.html
---

# bioconductor-rebook

## Overview

The `rebook` package provides an opinionated framework for modularizing large Bioconductor books. It allows authors to treat chapters as "donors" and "acceptors," where objects generated in one chapter can be retrieved from the cache and used in another without re-executing the code. It also facilitates seamless linking between different books hosted on Bioconductor.

## Core Workflows

### 1. Reusing Objects Between Chapters
To use an object from a different Rmarkdown file (the "donor") within the current chapter (the "acceptor"), use `extractCached()`.

```r
# Extract 'godzilla' from a specific chunk in a donor Rmd
rebook::extractCached(
    path = "path/to/donor_chapter.Rmd", 
    chunk = "chunk-label-name", 
    object = "godzilla"
)

# The object 'godzilla' is now available in the current environment
print(godzilla)
```

- **Mechanism**: It searches the *knitr* cache. If the donor hasn't been compiled, `rebook` will compile it automatically.
- **Multiple Objects**: Pass a character vector to the `object` argument.
- **State Management**: You can extract the same variable name from different chunks to get its state at different points in the donor's execution.

### 2. Reusing Content Across Different Packages
To extract objects from a chapter belonging to a different installed Bioconductor book package, use `extractFromPackage()`.

```r
rebook::extractFromPackage(
    rse.file = "chapter_filename.Rmd", 
    chunk = "analysis-chunk", 
    objects = "sce_object", 
    package = "DonorPackageName"
)
```

### 3. Linking to Other Bioconductor Books
Use `link()` to generate URLs to specific sections or figures in other books. This requires the destination book to be installed.

```r
# Link to a specific anchor in another book
rebook::link("installation-anchor", "OSCA.intro")

# Link to a figure or section
rebook::link("fig:sce-structure", "OSCA.intro")
```

### 4. Book Setup and Maintenance
When developing a book as an R package:

- **Preamble**: Call `chapterPreamble()` at the top of every `.Rmd` file (after the main title) to enable collapsible code blocks and proper styling.
  ```r
  # In an R chunk with results="asis"
  rebook::chapterPreamble()
  ```
- **Dependencies**: Use `updateDependencies()` to automatically scan your book chapters and update the `DESCRIPTION` file with required packages.
- **Configuration**: Use `configureBook()` to set up the Makefile in `vignettes/` and ensure the book can serve as a link destination for others.

### 5. Pretty Printing
Use `prettySessionInfo()` at the end of a chapter to generate a collapsible, clean session information block.

```r
rebook::prettySessionInfo()
```

## Tips for Success
- **Chunk Naming**: Always name your code chunks in donor chapters; `extractCached` relies on these labels to locate objects.
- **Caching**: Ensure `opts_chunk$set(cache = TRUE)` is active in donor chapters.
- **Package Metadata**: If your book links to or extracts from another book, add that book package to the `Suggests:` or `Imports:` field of your `DESCRIPTION` file.

## Reference documentation
- [Writing a book with reusable contents](./references/userguide.md)