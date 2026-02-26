---
name: bucketcache
description: "bucketcache is a Python library that provides persistent file-based caching for serializable objects and function return values. Use when user asks to create a persistent dictionary for data, cache function or method results to disk, or manage cache expiration with TTL."
homepage: https://github.com/RazerM/bucketcache
---


# bucketcache

## Overview

bucketcache is a Python library designed for versatile, persistent file caching. It provides a "Bucket" container that acts as a persistent dictionary for serializable objects and doubles as a powerful decorator for functions and class methods. It is particularly useful for long-running tasks where results should survive process restarts, allowing for configurable lifetimes (TTL) and custom serialization backends.

## Core Usage

### Initializing a Bucket
Create a bucket by specifying a directory path. You can define the cache lifetime using days, hours, minutes, or seconds.

```python
from bucketcache import Bucket

# Create a cache that expires after 24 hours
bucket = Bucket('path/to/cache_dir', hours=24)
```

### Persistent Dictionary Interface
The bucket can be used like a standard Python dictionary. Objects are automatically serialized to disk (Pickle is the default backend).

```python
# Storing data
bucket['my_key'] = {'data': [1, 2, 3]}

# Retrieving data
data = bucket['my_key']
```

## Function and Method Decoration

### Basic Function Decorator
Decorate functions to automatically cache their return values based on the input arguments.

```python
@bucket
def expensive_computation(x, y):
    return x ** y
```

### Class Method Decoration
When decorating methods within a class, you must explicitly set `method=True` to ensure the `self` instance is handled correctly.

```python
class DataService:
    @bucket(method=True)
    def fetch_remote_data(self, query):
        # Expensive network call
        pass
```

### Conditional Caching (nocache)
You can define a specific argument that, when passed, bypasses the cache.

```python
@bucket(nocache='refresh')
def get_api_data(endpoint, refresh=False):
    return requests.get(endpoint).json()

# This call bypasses the cache and updates it with new data
get_api_data('https://api.example.com', refresh=True)
```

## Expert Tips

### Cache Hit Callbacks
Use the `.callback` attribute on a decorated function to execute logic specifically when a cache hit occurs. This is useful for logging or monitoring cache efficiency.

```python
@expensive_function.callback
def expensive_function(callinfo):
    print(f"Cache hit for arguments: {callinfo.args}")
```

### Serialization Backends
While Pickle is the default, bucketcache supports configurable serialization. Ensure your objects are serializable by the chosen backend. If using the default Pickle backend, be aware of security implications when loading caches from untrusted sources.

### Handling Expiration
If a lifetime is set, bucketcache automatically invalidates files older than the specified duration. If no lifetime is provided, the cache remains valid indefinitely until manually cleared or the files are deleted.

## Reference documentation
- [bucketcache README](./references/github_com_RazerM_bucketcache.md)