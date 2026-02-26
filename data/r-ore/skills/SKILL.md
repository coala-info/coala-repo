---
name: r-ore
description: The r-ore package provides an interface to the Onigmo regular expression library for high-performance string manipulation in R. Use when user asks to perform regex matching with compiled objects, use Ruby-style syntax, execute function-based substitutions, or handle complex character encodings.
homepage: https://cloud.r-project.org/web/packages/ore/index.html
---


# r-ore

name: r-ore
description: Expert guidance for using the 'ore' R package, an interface to the Onigmo regular expression library. Use this skill when you need to perform high-performance string manipulation in R, work with first-class compiled regex objects, use Ruby-style regex syntax, perform function-based substitutions, or handle complex character encodings.

# r-ore

## Overview
The `ore` package provides a powerful alternative to R's base regular expression functions. It is based on the Onigmo library (a fork of Oniguruma), which is the engine used by Ruby. Key advantages include compiled regex objects, better performance on large strings, support for various encodings, and flexible substitution methods (including using R functions as replacers).

## Installation
To install the package from CRAN:
```r
install.packages("ore")
```

## Core Workflow

### 1. Creating Regex Objects
Unlike base R, `ore` treats regular expressions as first-class objects.
```r
library(ore)
# Compile a regex
re <- ore("-?\\d+") 
# Check properties
print(re)
```

### 2. Searching and Matching
The package uses `ore_search` for finding matches. It returns an `orematch` object containing offsets, lengths, and captured groups.

| Task | `ore` Function | Base R Equivalent |
| :--- | :--- | :--- |
| Logical check | `ore_ismatch(re, text)` or `text %~% re` | `grepl()` |
| Find first match | `ore_search(re, text)` | `regexpr()` |
| Find all matches | `ore_search(re, text, all=TRUE)` | `gregexpr()` |
| Filter vector | `text %~|% re` | `grep(value=TRUE)` |

### 3. Extracting Results
Use helper functions to pull text from `orematch` objects:
- `matches(match)`: Returns the full matched strings.
- `groups(match)`: Returns a matrix of captured parenthesized groups.
- `match[i, j]`: Indexing shorthand (i-th string, j-th group).

### 4. Substitutions
`ore_subst` supports back-references (`\1`, `\k<name>`) and R functions.
```r
# Using a function for replacement
text <- "I have 2 dogs and 3 cats"
ore_subst(ore("\\d+"), function(m) as.numeric(m)^2, text, all=TRUE)
# Result: "I have 4 dogs and 9 cats"
```

### 5. String Interpolation
The `es()` function provides string interpolation similar to Ruby or `glue`.
```r
name <- "World"
es("Hello, #{name}!") # "Hello, World!"
```

## Advanced Features

### Pattern Dictionary
Store and reuse common regex fragments to build complex patterns.
```r
ore_dict(digits="\\d+", letter="[A-Za-z]")
re <- ore(digits, "-", letter) # Combines into /(\d+)-([A-Za-z])/
```

### File and Connection Search
Search directly in files or URLs without loading the entire content into R memory first.
```r
# Search a URL for a pattern
ore_search("\\bi[A-Z]\\w+", url("https://www.apple.com"))

# Search a file with specific encoding
ore_search("pattern", ore_file("path/to/file.txt", encoding="SHIFT_JIS"))
```

### Encodings and Syntax
- **Encodings**: Specify `encoding` in `ore()` (e.g., "UTF-8", "ASCII", "SHIFT_JIS").
- **Fixed Matching**: Use `syntax="fixed"` in `ore()` for literal string matching (equivalent to `fixed=TRUE`).
- **Escaping**: Use `ore_escape(string)` to neutralize regex special characters.

## Reference documentation
- [Oniguruma Regular Expressions (for R)](./references/README.md)