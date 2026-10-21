# s3gof3r CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| s3gof3r_gof3r_cp | Not completed | needs AWS credentials: gof3r stops with 'no AWS keys found' even for a public bucket (1000genomes) |
| s3gof3r_gof3r_get | Not completed | needs AWS credentials: gof3r stops with 'no AWS keys found' even for a public bucket (1000genomes) |
| s3gof3r_gof3r_put | Not completed | needs AWS credentials: gof3r stops with 'no AWS keys found' even for a public bucket (1000genomes) |
| s3gof3r_gof3r_rm | Not completed | needs AWS credentials: gof3r stops with 'no AWS keys found' even for a public bucket (1000genomes) |

## s3gof3r_gof3r_get

### Tool Description
get (download) object from S3

### Metadata
- **Docker Image**: quay.io/biocontainers/s3gof3r:0.5.0--1
- **Homepage**: https://github.com/rlmcpherson/s3gof3r
- **Package**: https://anaconda.org/channels/bioconda/packages/s3gof3r/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
  gof3r [OPTIONS] get [get-OPTIONS]

get (download) object from S3

Application Options:
  -v, --version          Print version
  -m, --manpage          Create gof3r.man man page in current directory
  -i, --writeini         Write .gof3r.ini in current user's home directory

Help Options:
  -h, --help             Show this help message

[get command options]
      -k, --key=         S3 object key
      -b, --bucket=      S3 bucket
      -p, --path=        Path to file. Defaults to standard output for
                         streaming.
          --no-ssl       Do not use SSL for endpoint connection.
          --no-md5       Do not use md5 hash checking to ensure data integrity.
                         By default, the md5 hash of is calculated concurrently
                         during puts, stored at <bucket>.md5/<key>.md5, and
                         verified on gets.
      -c, --concurrency= Concurrency of transfers (default: 10)
      -s, --partsize=    Initial size of concurrent parts, in bytes (default:
                         20971520)
          --endpoint=    Amazon S3 endpoint (default: s3.amazonaws.com)
          --debug        Enable debug logging.
      -v, --versionId=   Version ID of the object. Incompatible with md5 check
                         (use --no-md5).
```

## s3gof3r_gof3r_put

### Tool Description
put (upload) data to S3 object

### Metadata
- **Docker Image**: quay.io/biocontainers/s3gof3r:0.5.0--1
- **Homepage**: https://github.com/rlmcpherson/s3gof3r
- **Package**: https://anaconda.org/channels/bioconda/packages/s3gof3r/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
  gof3r [OPTIONS] put [put-OPTIONS]

put (upload) data to S3 object

Application Options:
  -v, --version          Print version
  -m, --manpage          Create gof3r.man man page in current directory
  -i, --writeini         Write .gof3r.ini in current user's home directory

Help Options:
  -h, --help             Show this help message

[put command options]
      -k, --key=         S3 object key
      -b, --bucket=      S3 bucket
      -p, --path=        Path to file. Defaults to standard output for
                         streaming.
          --no-ssl       Do not use SSL for endpoint connection.
          --no-md5       Do not use md5 hash checking to ensure data integrity.
                         By default, the md5 hash of is calculated concurrently
                         during puts, stored at <bucket>.md5/<key>.md5, and
                         verified on gets.
      -c, --concurrency= Concurrency of transfers (default: 10)
      -s, --partsize=    Initial size of concurrent parts, in bytes (default:
                         20971520)
          --endpoint=    Amazon S3 endpoint (default: s3.amazonaws.com)
          --debug        Enable debug logging.
      -m, --header=      HTTP headers. May be used to set custom metadata,
                         server-side encryption etc.
          --acl=         canned acl to apply to the object
```

## s3gof3r_gof3r_cp

### Tool Description
copy S3 objects to or from S3 and local files

### Metadata
- **Docker Image**: quay.io/biocontainers/s3gof3r:0.5.0--1
- **Homepage**: https://github.com/rlmcpherson/s3gof3r
- **Package**: https://anaconda.org/channels/bioconda/packages/s3gof3r/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
  gof3r [OPTIONS] cp [cp-OPTIONS] Source Dest

copy S3 objects to or from S3 and local files

Application Options:
  -v, --version          Print version
  -m, --manpage          Create gof3r.man man page in current directory
  -i, --writeini         Write .gof3r.ini in current user's home directory

Help Options:
  -h, --help             Show this help message

[cp command options]
          --no-ssl       Do not use SSL for endpoint connection.
          --no-md5       Do not use md5 hash checking to ensure data integrity.
                         By default, the md5 hash of is calculated concurrently
                         during puts, stored at <bucket>.md5/<key>.md5, and
                         verified on gets.
      -c, --concurrency= Concurrency of transfers (default: 10)
      -s, --partsize=    Initial size of concurrent parts, in bytes (default:
                         20971520)
          --endpoint=    Amazon S3 endpoint (default: s3.amazonaws.com)
          --debug        Enable debug logging.
      -m, --header=      HTTP headers. May be used to set custom metadata,
                         server-side encryption etc.
          --acl=         canned acl to apply to the object

[cp command arguments]
  Source
  Dest
```

## s3gof3r_gof3r_rm

### Tool Description
delete from S3

### Metadata
- **Docker Image**: quay.io/biocontainers/s3gof3r:0.5.0--1
- **Homepage**: https://github.com/rlmcpherson/s3gof3r
- **Package**: https://anaconda.org/channels/bioconda/packages/s3gof3r/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
  gof3r [OPTIONS] rm <path> [rm-OPTIONS]

Application Options:
  -v, --version        Print version
  -m, --manpage        Create gof3r.man man page in current directory
  -i, --writeini       Write .gof3r.ini in current user's home directory

Help Options:
  -h, --help           Show this help message

[rm command options]
          --endpoint=  Amazon S3 endpoint (default: s3.amazonaws.com)
          --debug      Enable debug logging.
      -v, --versionId= version ID of the object version to delete
```
