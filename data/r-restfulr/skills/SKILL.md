---
name: r-restfulr
description: Models a RESTful service as if it were a nested R list.</p>
homepage: https://cran.r-project.org/web/packages/restfulr/index.html
---

# r-restfulr

name: r-restfulr
description: Use this skill to interface with RESTful web services using the restfulr R package. It is ideal for modeling REST APIs as nested R lists and performing CRUD operations (GET, POST, PUT, DELETE) using R-native syntax. Use when you need to navigate API endpoints as S4 objects or handle automated conversion between R data structures and JSON/XML/YAML.

## Overview

The `restfulr` package provides a high-level, object-oriented interface to RESTful web services. It abstracts HTTP communication by modeling remote resources as R objects. The core philosophy is to treat a web service as a nested list, where URI paths are navigated using standard R operators like `$` and `[[`.

## Installation

To install the package from CRAN:

```R
install.packages("restfulr")
```

## Core Workflow

### 1. Initialize a Resource
Create a `RestResource` object using the base URL of the API.

```R
library(restfulr)
res <- RestResource("https://api.example.com/v1")
```

### 2. Navigate Endpoints
Navigate the API hierarchy using `$` or `[[`. This does not trigger a network request yet; it simply defines the target URI.

```R
# Access https://api.example.com/v1/users/123
user_res <- res$users[["123"]]
```

### 3. Perform CRUD Operations
Map standard HTTP verbs to R functions:

*   **GET**: Use `read()`
*   **POST**: Use `create()`
*   **PUT**: Use `update()`
*   **DELETE**: Use `delete()`

```R
# GET request
user_data <- read(user_res)

# POST request (create a new sub-resource)
new_user <- list(name = "John Doe", email = "john@example.com")
create(res$users, new_user)

# PUT request (update existing)
update(user_res, list(name = "John Updated"))

# DELETE request
delete(user_res)
```

## Advanced Usage

### Media Types and Serialization
`restfulr` automatically detects and handles content types (JSON, XML, YAML) based on the HTTP headers. You can explicitly specify a container or media type if the server requires specific formatting.

### Authentication
Pass authentication headers or RCurl options through the `RestResource` constructor or via `options`.

```R
# Example using basic auth via RCurl options
res <- RestResource("https://api.example.com", 
                    extraArgs = list(userpwd = "user:password", httpauth = 1L))
```

### Query Parameters
Add query parameters to a resource using the `query()` function or by passing them as arguments.

```R
search_res <- res$search(q = "query_term", limit = 10)
results <- read(search_res)
```

## Tips for Success
*   **Lazy Evaluation**: Remember that navigating with `$` only builds the URI. The network request only happens when `read()`, `create()`, `update()`, or `delete()` is called.
*   **S4 Classes**: `restfulr` relies heavily on S4. If you need to extend functionality, look into the `RestResource` and `Media` class definitions.
*   **Error Handling**: The package converts HTTP error codes into R errors. Wrap calls in `tryCatch()` for robust API integrations.

## Reference documentation
- [restfulr: R Interface to RESTful Web Services](./references/home_page.md)