---
name: simplejson
description: simplejson provides a flexible way to interact with and manipulate JSON data in Go without requiring predefined structs. Use when user asks to parse dynamic JSON, navigate nested data structures using method chaining, or modify JSON payloads on the fly.
homepage: https://github.com/bitly/go-simplejson
metadata:
  docker_image: "quay.io/biocontainers/simplejson:3.8.1--py35_0"
---

# simplejson

## Overview
The `go-simplejson` package provides a flexible way to handle JSON in Go. Unlike the standard library's `encoding/json`, which typically requires predefined structs for unmarshaling, `simplejson` allows for a more fluid, "jQuery-like" interaction with JSON objects. It is particularly useful for quick data extraction from complex API responses, building dynamic JSON payloads, or processing JSON where the structure is not guaranteed.

## Core Usage Patterns

### Initialization
Load JSON data from bytes or an `io.Reader`:

```go
// From bytes
js, err := simplejson.NewJson(bodyBytes)

// From a reader (e.g., http.Response.Body)
js, err := simplejson.NewFromReader(resp.Body)
```

### Navigating and Extracting Data
Use method chaining to reach deep keys. `Get` returns a new `*Json` object, allowing for continuous navigation.

- **Key Access**: `js.Get("top_level").Get("nested_key")`
- **Array Indexing**: `js.Get("items").GetIndex(0)`
- **Path Access**: `js.GetPath("metadata", "user", "id")`

### Type-Safe Extraction
The library provides two ways to get values: standard methods (returning value and error) and "Must" methods (returning value and a default if the key is missing or type is wrong).

- **Standard**: `str, err := js.Get("name").String()`
- **Must (Safe Defaults)**: `str := js.Get("name").MustString("default_name")`
- **Arrays**: `arr, err := js.Get("tags").Array()`
- **Maps**: `m, err := js.Get("data").Map()`

### Modifying JSON
You can update or delete keys within an existing `*Json` object:

- **Set Value**: `js.Set("status", "active")`
- **Set Deep Path**: `js.SetPath([]string{"settings", "theme"}, "dark")`
- **Delete Key**: `js.Del("temporary_token")`

### Output
Convert the internal structure back to JSON format:

- **Standard Encode**: `bytes, err := js.Encode()`
- **Formatted/Pretty Print**: `bytes, err := js.EncodePretty()`

## Expert Tips
- **Check for Existence**: To verify if a key exists without triggering errors, check the returned error from a type method or check if the `*Json` object returned by `Get` is nil-safe (the library handles nil internally to prevent panics during chaining).
- **Interface Access**: Use `.Interface()` to get the underlying `interface{}` if you need to pass the data to a function that doesn't support `simplejson.Json`.
- **Numeric Flexibility**: The library is robust with numeric types; use `Int64()`, `Uint64()`, or `Float64()` depending on the precision required.

## Reference documentation
- [go-simplejson README](./references/github_com_bitly_go-simplejson.md)