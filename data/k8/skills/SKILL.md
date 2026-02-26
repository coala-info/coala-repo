---
name: k8
description: k8 is a specialized JavaScript shell built on the Google V8 engine designed for high-performance, synchronous CLI text processing and bioinformatics tasks. Use when user asks to run JavaScript scripts for heavy data processing, perform efficient file I/O on large datasets, or calculate reverse complements of DNA sequences.
homepage: https://github.com/attractivechaos/k8
---


# k8

## Overview

k8 is a specialized JavaScript shell built on the Google V8 engine, designed specifically for CLI-based text processing. While modern runtimes like Node.js prioritize asynchronous I/O for web services, k8 provides synchronous APIs that make it easier to write scripts for heavy data processing. This is especially valuable for bioinformatics and data science tasks where sequential execution and low-level memory control are required to handle massive datasets efficiently.

## Command Line Usage

### Basic Execution
- **Run a script**: `k8 script.js [arguments]`
- **Execute a one-liner**: `k8 -e 'print(Math.log(2))'`
- **Set memory limit**: Use `-m <int>` to set the maximum old space size (in MB). The default is often 16GB (16384MB) in recent versions.

### Arguments
Inside a script, command-line arguments are accessed via the global `arguments` array (e.g., `arguments[0]`, `arguments[1]`).

## Core API and Best Practices

### Efficient File I/O
The `File` object provides buffered, synchronous I/O. It automatically detects and decompresses gzip files when reading.

```javascript
let file = new File("input.txt.gz", "r"); // "r" for read, "w" for write
let buf = new Bytes();
while (file.readline(buf) >= 0) {
    // Process line stored in buf
}
file.close();
buf.destroy();
```

### Memory Management with Bytes
The `Bytes` object is a resizable byte array. **Critical**: Memory for `Bytes` is allocated outside of the V8 garbage collector. You must manually deallocate it to avoid memory leaks.

- **Initialization**: `let buf = new Bytes();`
- **Deallocation**: `buf.destroy();`
- **Conversion**: `buf.toString()` converts the buffer to a standard JS string.

### Global Functions
- `print(...)`: Outputs to stdout, TAB-delimited if multiple arguments are provided.
- `warn(...)`: Outputs to stderr.
- `load(file)`: Executes an external JS file. Searches the current directory, script directory, and `K8_PATH`.
- `exit(code)`: Terminates the process with the specified exit code.

### Specialized Bioinformatics Functions
- `k8_revcomp(seq)`: Returns the reverse complement of a DNA sequence string.
- `k8_revcomp(bytes_obj)`: Performs an in-place reverse complement on a `Bytes` object.

## Expert Tips

1. **Line-by-Line Processing**: Always use `file.readline(buf)` instead of reading the entire file into memory. This allows k8 to process files much larger than the available RAM.
2. **Delimiter Control**: `file.readline(buf, sep)` accepts a separator. Use `0` for SPACE, `1` for TAB, and `2` for Newline (default).
3. **Binary Data**: Use `k8_read_file(filename)` to read an entire file directly into an `ArrayBuffer` for binary manipulation.
4. **Encoding**: Use `k8_decode(buffer, "utf-8")` and `k8_encode(string, "utf-8")` for explicit string/buffer conversions.

## Reference documentation
- [k8 GitHub Repository](./references/github_com_attractivechaos_k8.md)
- [k8 Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_k8_overview.md)