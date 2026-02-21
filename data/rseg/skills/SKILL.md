---
name: rseg
description: rseg is a pure Ruby implementation for Chinese word segmentation.
homepage: https://github.com/yzhang/rseg
---

# rseg

## Overview
rseg is a pure Ruby implementation for Chinese word segmentation. It transforms continuous Chinese strings into arrays of discrete words using a dictionary-based approach (utilizing CC-CEDICT and Wikipedia data). The tool is particularly useful for Ruby developers who need a dependency-free segmentation routine that can operate as an inline library or as a standalone network service to improve performance across multiple requests.

## Usage Patterns

### Inline Ruby Integration
For direct use within Ruby scripts, use the `segment` method. Note that the first call triggers a dictionary load which takes approximately 30 seconds.

```ruby
require 'rseg'

# Standard segmentation
words = Rseg.segment("需要分词的文章")
# Output: ['需要', '分词', '的', '文章']

# Manual dictionary loading to control startup timing
Rseg.load
```

### Client/Server (C/S) Mode
To avoid the dictionary loading penalty on every execution, use the C/S mode. This is the recommended pattern for high-frequency segmentation or CLI usage.

1. **Start the Server**:
   Run `rseg_server` in a persistent process. By default, it starts a Sinatra server on `http://localhost:4100`.

2. **CLI Client**:
   Once the server is running, use the `rseg` command for instant results:
   `rseg '需要分词的文章'`

3. **Remote Ruby Client**:
   Connect to the running server from Ruby code:
   ```ruby
   require 'rseg'
   Rseg.remote_segment("需要分词的文章")
   ```

## Expert Tips and Best Practices

*   **Dictionary Management**: If you need to use custom dictionaries, use `Rseg.load(path_to_dict)` to extend the default vocabulary.
*   **Performance Optimization**: In production environments, always prefer the C/S mode. The 30-second initialization overhead of the inline mode makes it unsuitable for short-lived CLI scripts or request-response cycles in web frameworks unless the process is long-running (like a background worker).
*   **Memory Considerations**: Since the dictionary is loaded into memory, ensure the environment has sufficient RAM (at least 512MB-1GB recommended for the process) to handle the internal data structures efficiently.
*   **Encoding**: Ensure your input strings are UTF-8 encoded to prevent segmentation errors or encoding mismatches.

## Reference documentation
- [rseg README](./references/github_com_yzhang_rseg.md)