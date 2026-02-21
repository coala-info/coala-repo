---
name: s3gof3r
description: s3gof3r (via the `gof3r` CLI) is a specialized tool designed for maximum throughput when interacting with Amazon S3.
homepage: https://github.com/rlmcpherson/s3gof3r
---

# s3gof3r

## Overview
s3gof3r (via the `gof3r` CLI) is a specialized tool designed for maximum throughput when interacting with Amazon S3. Unlike general-purpose S3 clients, it focuses on parallelized multipart uploads and downloads, making it the preferred choice for handling multi-gigabyte files and streaming workflows. It ensures end-to-end data integrity through parallel MD5 calculation and provides robust retry logic to handle S3 timeouts under high load.

## Core CLI Usage

### Streaming Uploads (put)
Use `put` to stream data from stdin directly to an S3 object. This is ideal for backups and log rotations.

```bash
# Stream a directory as a compressed tarball to S3
tar -czf - <my_dir/> | gof3r put -b <bucket_name> -k <object_key>

# Upload with custom metadata and server-side encryption
cat data.csv | gof3r put -b my-bucket -k data.csv -m x-amz-meta-project:research -m x-amz-server-side-encryption:AES256
```

### Streaming Downloads (get)
Use `get` to stream data from S3 to stdout.

```bash
# Stream an object from S3 and extract it locally
gof3r get -b <bucket_name> -k <object_key> | tar -xz

# Stream and monitor progress with 'pv'
gof3r get -b my-bucket -k large_file.iso | pv -a > local_file.iso
```

### File Copy (cp)
Use `cp` for standard file transfers between the local filesystem and S3.

```bash
# Upload a local file
gof3r cp /path/to/local_file s3://<bucket>/<key>

# Download an S3 object to a local path
gof3r cp s3://<bucket>/<key> /path/to/local_destination
```

## Authentication
The tool looks for credentials in the following order:
1.  **Environment Variables**:
    *   `AWS_ACCESS_KEY_ID`
    *   `AWS_SECRET_ACCESS_KEY`
    *   `AWS_SECURITY_TOKEN` (if using temporary credentials)
    *   `AWS_REGION` (optional, defaults to us-east-1)
2.  **IAM Roles**: Automatically uses EC2 instance metadata if environment variables are not set.

## Expert Tips and Best Practices

### Optimizing Performance
*   **Concurrency**: The default concurrency is 10. On high-bandwidth EC2 instances (e.g., 1Gbps+), you can increase performance by adjusting concurrency and part size, though the defaults are generally well-tuned for memory efficiency.
*   **S3 Accelerate**: If the bucket has S3 Transfer Acceleration enabled, ensure your environment or endpoint configuration reflects the accelerated endpoint for maximum speed.

### Memory Management
*   The tool is highly memory-efficient, recycling buffers used for parts.
*   With default settings (10 concurrency, 20MB part size), memory usage stays below 300MB.
*   To reduce the memory footprint further on resource-constrained systems, decrease the part size or concurrency.

### Data Integrity
*   s3gof3r calculates MD5 hashes in parallel during both upload and download.
*   It automatically checks the 'hash of hashes' (Etag) returned by S3 upon completion of multipart uploads.
*   On download, it verifies the calculated MD5 against the hash stored during upload.

## Reference documentation
- [s3gof3r README](./references/github_com_rlmcpherson_s3gof3r.md)