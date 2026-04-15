---
name: bioconductor-biocbook
description: This tool facilitates the creation, containerization, and publishing of versioned online books using Quarto and Bioconductor. Use when user asks to initialize a new book project, manage chapters and preambles, preview the book locally, or publish and version the book via GitHub.
homepage: https://bioconductor.org/packages/release/bioc/html/BiocBook.html
---

# bioconductor-biocbook

name: bioconductor-biocbook
description: Facilitate the creation, containerization, and publishing of package-based, versioned online books using Quarto and Bioconductor. Use this skill when a user needs to initialize a new BiocBook project, manage book chapters (preambles, chapters, editing), preview the book locally, or publish/version the book via GitHub and Bioconductor.

# bioconductor-biocbook

## Overview

The `BiocBook` package allows users to create technical documentation or workshop materials in a "book" format that is structured as an R package. It leverages Quarto for rendering and GitHub Actions for automatic containerization (Docker) and deployment (GitHub Pages). It is specifically designed to handle Bioconductor-specific versioning, ensuring that book versions align with Bioconductor releases.

## Core Workflow

### 1. Initializing a New Book
To create a new book project, use the `init()` function. This sets up a local directory and, by default, a remote GitHub repository based on a template.

```r
library(BiocBook)

# Initialize a new book project
# This creates the folder structure, DESCRIPTION file, and GitHub repository
init("MyAnalysisBook")

# For local-only testing without GitHub configuration:
init("MyLocalBook", .local = TRUE)
```

### 2. Managing the BiocBook Object
After initialization, interact with the book using a `BiocBook` object which points to the project directory.

```r
# Create a pointer to the book directory
bb <- BiocBook("MyAnalysisBook")

# View book status, chapters, and metadata
print(bb)
```

### 3. Adding and Editing Content
Content is stored as `.qmd` (Quarto) files within the `inst/pages/` directory.

*   **Add Preamble:** `add_preamble(bb)` creates `inst/pages/preamble.qmd`.
*   **Add Chapter:** `add_chapter(bb, title = "Differential Expression")` creates a new chapter file and updates the book configuration.
*   **Edit Page:** `edit_page(bb, page = "chapter-1.qmd")` opens the specified file for editing.

```r
add_preamble(bb)
add_chapter(bb, title = "Data Exploration")
```

### 4. Previewing and Publishing
Before sharing, preview the rendered output locally.

*   **Preview:** `preview(bb)` compiles the Quarto book and opens a local preview.
*   **Status:** `status(bb)` checks the published versions on the `gh-pages` branch.
*   **Publish:** `publish(bb)` commits changes and pushes them to the remote repository to trigger deployment.

```r
# Render the book locally to check formatting
preview(bb)

# Push changes to GitHub for online deployment
publish(bb)
```

## Key Components
*   **DESCRIPTION file:** Contains metadata about the book (Title, Author, Version).
*   **inst/index.qmd:** The landing page of the book.
*   **inst/assets/_book.yml:** The Quarto configuration file defining the book structure and sidebar.

## Reference documentation

- [BiocBook](./references/BiocBook.md)