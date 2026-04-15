---
name: r-hwriter
description: The r-hwriter tool exports R objects like data frames, matrices, and images into formatted HTML documents and tables. Use when user asks to generate HTML reports, convert R data to HTML tables, embed images in web pages, or apply CSS styling to R output.
homepage: https://cloud.r-project.org/web/packages/hwriter/index.html
---

# r-hwriter

name: r-hwriter
description: Expert guidance for using the 'hwriter' R package to output R objects (data frames, matrices, images) into HTML format. Use this skill when you need to generate HTML reports, create formatted HTML tables from R data, or build simple web pages directly from an R session.

# r-hwriter

## Overview
The `hwriter` package is a lightweight and versatile tool for exporting R objects into HTML. It specializes in converting R data structures (like data frames and matrices) into highly customizable HTML tables, supporting CSS styling, pagination, and image embedding.

## Installation
To install the package from CRAN:
```r
install.packages("hwriter")
```

## Core Functions
- `hwrite()`: The primary function. It converts R objects to HTML strings or writes them to a file/connection.
- `openPage()` / `closePage()`: Used to create a full HTML document with headers, scripts, and CSS links.
- `hwriteImage()`: Specifically for embedding images into HTML.
- `hmakeTag()`: A low-level utility to create arbitrary HTML tags.

## Common Workflows

### Creating a Basic HTML Table
```r
library(hwriter)
# Convert a data frame to an HTML string
df <- data.frame(Name=c("A", "B"), Value=c(10, 20))
html_table <- hwrite(df)

# Write directly to a file
hwrite(df, page = "report.html")
```

### Building a Complete HTML Page
To create a standalone report with a title and CSS:
```r
p <- openPage("my_report.html", title = "Analysis Results", link.css = "style.css")
hwrite("Summary Table", p, heading = 1)
hwrite(mtcars[1:5, ], p, row.names = FALSE, br = TRUE)
hwriteImage("plot.png", p)
closePage(p)
```

### Customizing Table Appearance
`hwrite` accepts many arguments to control HTML attributes:
- `border`: Set table border thickness.
- `cellpadding` / `cellspacing`: Control spacing.
- `row.bgcolor` / `col.bgcolor`: Set background colors for rows or columns.
- `table.class`: Assign a CSS class to the table.

Example with row coloring:
```r
hwrite(iris[1:5,], page = "colored.html", 
       row.bgcolor = list('gray' = c(2, 4)))
```

## Tips and Best Practices
- **Vectorization**: Many arguments in `hwrite` (like `color` or `link`) are vectorized, allowing you to apply different styles or hyperlinks to individual cells in a table.
- **Appending**: Use `append = TRUE` in `hwrite` to add content to an existing file without overwriting it.
- **Hyperlinks**: You can easily turn table cells into links by passing a matrix of URLs to the `link` argument that matches the dimensions of your data.
- **Interactive Examples**: Run `example(hwriter)` in an R session to generate a comprehensive local HTML file demonstrating all package features.

## Reference documentation
- [hwriter: HTML Writer - Outputs R Objects in HTML Format](./references/hwriter.md)