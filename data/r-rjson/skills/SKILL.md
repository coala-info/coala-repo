---
name: r-rjson
description: Converts R object into JSON objects and vice-versa.</p>
homepage: https://cloud.r-project.org/web/packages/rjson/index.html
---

# r-rjson

name: r-rjson
description: Use this skill when you need to convert R objects to JSON strings or parse JSON data into R structures using the rjson package. This skill is ideal for web API integration, data serialization, and setting up JSON-RPC servers for inter-process communication.

# r-rjson

## Overview
The `rjson` package provides fast and efficient conversion between R objects and JSON (JavaScript Object Notation). It is a lightweight alternative for handling JSON data, supporting standard R types like lists, vectors, and data frames, and includes specialized support for JSON-RPC protocols.

## Installation
To install the package, use the following command in R:
```R
install.packages("rjson")
```

## Core Functions

### toJSON
Converts an R object into a JSON string.
```R
library(rjson)
x <- list( alpha = 1:5, beta = "test", gamma = TRUE )
json_string <- toJSON(x)
```
- **indent**: Use `indent = 1` (or more) to create pretty-printed, human-readable JSON.
- **method**: Defaults to "C" for speed, but can be set to "R" for debugging.

### fromJSON
Parses a JSON string or file into an R object.
```R
# From a string
r_obj <- fromJSON(json_str = '[1, 2, {"a":1}]')

# From a file
r_obj <- fromJSON(file = "data.json")
```
- **unexpected.escape**: Controls behavior for unexpected escape sequences (e.g., "error", "skip", or "keep").

## JSON-RPC Server
`rjson` includes a framework for creating a JSON-RPC server, allowing other programs to call R functions over standard input/output.

### Workflow
1. **Server Location**: Sample server code is located in the `rpc_server` directory of the installed package library.
2. **Execution**: The server is typically started via `start_server` (Unix) or `start_server.bat` (Windows).
3. **Custom Functions**: You can pass a source file as a parameter to the server to expose your own R functions to the RPC client.
4. **Security**: Be cautious when exposing `eval` or accepting input from untrusted sources, as the RPC interface executes R code directly.

## Tips and Best Practices
- **Simplification**: `rjson` typically converts JSON arrays to R vectors and JSON objects to R lists.
- **Performance**: The C-based implementation is the default and significantly faster for large datasets.
- **Handling NAs**: R's `NA` values are converted to JSON `null`.

## Reference documentation
- [JSON RPC server for R](./references/json_rpc_server.md)