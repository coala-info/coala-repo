---
name: r-htmltools
description: The r-htmltools package provides tools to programmatically generate, manipulate, and manage HTML tags and web dependencies within R. Use when user asks to create HTML tags, manage CSS and JavaScript dependencies, query or modify HTML structures, or render R objects as web content.
homepage: https://cloud.r-project.org/web/packages/htmltools/index.html
---

# r-htmltools

name: r-htmltools
description: Expert guidance for using the R package 'htmltools' to generate, manipulate, and manage HTML tags, dependencies, and CSS. Use this skill when you need to create HTML programmatically in R, manage web dependencies for Shiny or R Markdown, or perform low-level HTML manipulation (escaping, CSS parsing, tag querying).

## Overview

The `htmltools` package provides a suite of tools for generating HTML from R. It is the foundation for the Shiny web framework and R Markdown. It allows for the creation of HTML tags using R functions, management of CSS/JS dependencies, and sophisticated querying of HTML structures.

## Installation

```r
install.packages("htmltools")
library(htmltools)
```

## Core Workflows

### 1. Creating HTML Tags
Use tag functions to create HTML elements. Common tags are available directly (e.g., `div()`, `p()`), while others are accessed via the `tags` list.

```r
# Basic tag creation
my_div <- div(
  class = "container",
  h1("Title"),
  p("This is a ", strong("bold"), " word.")
)

# Using the tags list for less common tags
my_page <- tags$article(
  tags$header(h2("Article Header")),
  tags$section("Content here")
)

# Boolean attributes (use NA)
tags$audio(controls = NA, src = "audio.mp3")
```

### 2. Managing CSS
The `css()` function helps build inline style strings with R-friendly syntax (using `.` or `_` instead of `-`).

```r
style_str <- css(
  font_family = "Helvetica",
  margin_top = "10px",
  "background-color" = "#f0f0f0"
)
# Result: "font-family:Helvetica;margin-top:10px;background-color:#f0f0f0;"
```

### 3. HTML Dependencies
Dependencies (JS/CSS) are managed via `htmlDependency()`. This ensures libraries like jQuery or Bootstrap are only loaded once, even if multiple components require them.

```r
my_dep <- htmlDependency(
  name = "my-lib",
  version = "1.0.0",
  src = c(file = "path/to/lib"),
  script = "script.js",
  stylesheet = "style.css"
)

# Attach to a tag
my_tag <- div("Hello")
my_tag <- attachDependencies(my_tag, my_dep)
```

### 4. Querying and Modifying Tags (tagQuery)
`tagQuery()` provides a jQuery-like interface to modify existing tag objects.

```r
ui <- div(class = "parent", a(href = "#", "Link"))

# Add a class to the anchor tag inside the div
modified_ui <- tagQuery(ui)$
  find("a")$
  addClass("btn btn-primary")$
  allTags()
```

### 5. Rendering and Saving
Convert tags to character strings or save them as HTML files.

```r
# To character
as.character(div("test"))

# Save to file (handles dependencies automatically)
save_html(my_tag, "index.html")

# Preview in viewer/browser
browsable(my_tag)
```

## Key Functions

- `HTML()`: Marks text as "raw HTML" to prevent escaping.
- `tagList()`: Groups multiple tags together without a parent container.
- `withTags()`: Allows calling tag functions without the `tags$` prefix.
- `validateCssUnit()`: Ensures values are valid CSS units (e.g., "10px", "50%").
- `plotTag()`: Captures an R plot and converts it into a self-contained `<img>` tag.

## Tips and Best Practices

- **Whitespace**: Use the `.noWS` argument (e.g., `.noWS = "outside"`) in tag functions to control generated HTML whitespace for tight layouts.
- **Singletons**: Use `singleton()` for elements (like JS scripts) that should only appear once in a document head, regardless of how many times the component is called.
- **Escaping**: `htmltools` automatically escapes text. Use `HTML()` only when you are certain the input string contains safe, pre-formatted HTML.
- **Templates**: Use `htmlTemplate()` to inject R-generated tags into an existing HTML file containing `{{ variable_name }}` placeholders.

## Reference documentation

- [Reference Manual](./references/reference_manual.md)