---
name: r-jsonlite
description: The r-jsonlite tool provides fast, bidirectional conversion between R objects and JSON data structures. Use when user asks to parse JSON strings, convert R data frames to JSON, interact with REST APIs, or handle paged data results.
homepage: https://cloud.r-project.org/web/packages/jsonlite/index.html
---


# r-jsonlite

name: r-jsonlite
description: Comprehensive JSON parsing and generation in R. Use this skill when you need to convert between R objects (data frames, lists, vectors) and JSON strings or files. It is particularly effective for interacting with REST APIs, handling paged data, and building data pipelines where R structures must be serialized or deserialized without loss of type information.

## Overview

The jsonlite package provides a fast, bidirectional mapping between JSON data and R's main data types. Unlike other parsers, it is optimized for statistical data, allowing for seamless conversion between JSON arrays and R data frames, matrices, or vectors without manual data munging.

## Installation

To install the package from CRAN:

install.packages("jsonlite")

## Core Functions

### Parsing JSON

The primary function for reading JSON is fromJSON(). It can accept a JSON string, a file path, or a URL.

# Parse a JSON string or URL
data <- fromJSON("https://api.github.com/users/hadley/repos")

# Control simplification (enabled by default)
data <- fromJSON(json_string, simplifyVector = TRUE, simplifyDataFrame = TRUE, simplifyMatrix = TRUE)

# Flatten nested data frames automatically
data <- fromJSON(url, flatten = TRUE)

### Generating JSON

The toJSON() function converts R objects into JSON strings.

# Convert a data frame to JSON
json_output <- toJSON(mtcars, pretty = TRUE)

# Common arguments
toJSON(x, 
       auto_unbox = TRUE,    # Convert length-1 vectors to JSON scalars
       dataframe = "rows",   # Format for data frames: "rows", "columns", or "values"
       null = "null",        # How to handle NULLs: "null" or "list"
       na = "null")          # How to handle NAs: "null" or "string"

## Simplification Logic

jsonlite automatically simplifies JSON structures into the most appropriate R class:

1. Array of primitives (strings, numbers, booleans): Becomes an Atomic Vector.
2. Array of objects (key-value pairs): Becomes a Data Frame.
3. Array of arrays (equal length): Becomes a Matrix.

To keep the structure as a nested list, set the corresponding simplify argument to FALSE.

## Common Workflows

### Interacting with REST APIs

jsonlite handles the connection and parsing in one step.

library(jsonlite)
gh_data <- fromJSON("https://api.github.com/repos/ropensci/jsonlite/issues")
# Access nested fields using standard R syntax
logins <- gh_data$user$login

### Handling Paged Data

When an API returns data in pages, collect them in a list and use rbind_pages() to combine them into a single data frame. This is more robust than rbind() as it handles varying column names or nested structures.

baseurl <- "https://api.example.com/data?page="
pages <- list()
for(i in 0:5){
  mydata <- fromJSON(paste0(baseurl, i))
  pages[[i+1]] <- mydata$results
}
combined_df <- rbind_pages(pages)

### Formatting and Validation

# Make JSON human-readable
pretty_json <- prettify(json_string)

# Compress JSON by removing whitespace
min_json <- minify(json_string)

# Check if a string is valid JSON
is_valid <- validate(json_string)

## Tips for Success

1. Use flatten = TRUE: When dealing with deeply nested JSON from APIs, flattening converts nested objects into prefixed columns (e.g., user.name, user.id), making the data frame easier to work with.
2. auto_unbox = TRUE: When generating JSON for web APIs, you often want length-1 R vectors to appear as scalars (e.g., "name": "John") rather than arrays (e.g., "name": ["John"]).
3. Date Handling: Use the POSIXt or Date classes in R; toJSON() provides various ISO8601 and epoch formats via the "Date" and "POSIXt" arguments.
4. Large Datasets: For very large JSON files (NDJSON), use stream_in() and stream_out() to process data in chunks and avoid memory issues.

## Reference documentation

- [Getting started with JSON and jsonlite](./references/json-aaquickstart.Rmd)
- [Fetching JSON data from REST APIs](./references/json-apis.Rmd)
- [Combining pages of JSON data with jsonlite](./references/json-paging.Rmd)