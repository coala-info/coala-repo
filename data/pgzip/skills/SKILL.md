---
name: pgzip
description: pgzip is a parallelized gzip implementation that increases throughput by distributing compression and decompression tasks across multiple CPU cores. Use when user asks to compress data in parallel, decompress files with read-ahead optimization, or tune gzip performance using custom concurrency settings.
homepage: https://github.com/klauspost/pgzip
metadata:
  docker_image: "quay.io/biocontainers/pgzip:0.3.5"
---

# pgzip

## Overview
pgzip provides a parallelized implementation of the gzip format, significantly increasing throughput by distributing compression tasks across multiple CPU cores. It produces standard, fully compatible gzip files that can be read by any conventional gzip tool. This skill focuses on optimizing performance through concurrency settings and understanding the thresholds where parallel processing provides the most benefit.

## Installation
Install the tool and its dependencies using the Go toolchain:
```bash
go get github.com/klauspost/pgzip/...
go get -u github.com/klauspost/compress
```

## Go Library Integration
To use pgzip as a drop-in replacement for the standard library, update your imports:
```go
import gzip "github.com/klauspost/pgzip"
```

### Configuring Concurrency
The primary advantage of pgzip is the ability to tune block sizes and parallel workers. Use `SetConcurrency(blockSize, blocks int)` to optimize for your hardware:

- **blockSize**: The approximate size of data chunks to be compressed in parallel.
- **blocks**: The number of blocks to process concurrently.

**Default Settings:**
- Block size: 1MB
- Blocks: `runtime.GOMAXPROCS(0)`

**Example Implementation:**
```go
var b bytes.Buffer
w := gzip.NewWriter(&b)
// Optimize for a specific workload (e.g., 100k blocks, 10 goroutines)
w.SetConcurrency(100000, 10)
w.Write([]byte("data"))
w.Close()
```

## Decompression Optimization
Decompression in pgzip is optimized through a "read-ahead" mechanism. It decodes data into a buffer before the reader requests it, ensuring that I/O operations are non-blocking if the decompressor stays ahead of the consumer.

To customize decompression buffering, use `NewReaderN`:
```go
// r is an io.Reader, blockSize is the decode chunk, blocks is the look-ahead count
reader, err := pgzip.NewReaderN(r, blockSize, blocks)
```

## Performance Best Practices
- **Data Size Threshold**: Only use pgzip for data larger than 1MB. For smaller files, the overhead of managing goroutines and block splitting may result in slower performance than standard single-threaded gzip.
- **Block Size Tuning**: For most high-core-count systems, a block size of 250k is a "sweet spot" for balancing memory usage and compression speed.
- **Worker Allocation**: Set the number of blocks to approximately twice the number of available CPU cores to ensure the pipeline remains full and handles spikes in data throughput efficiently.
- **Memory Management**: pgzip uses `sync.Pool` to reduce GC pressure. Ensure you call `Close()` on writers to return buffers to the pool.
- **Non-Blocking Writes**: Because pgzip buffers blocks for parallel processing, calls to `Write()` will only block if the internal queue of blocks is full. This can naturally smooth out performance in data pipelines.

## Reference documentation
- [pgzip README](./references/github_com_klauspost_pgzip.md)