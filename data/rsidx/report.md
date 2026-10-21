# rsidx CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| rsidx_index | PASS |  |
| rsidx_search | PASS |  |

## rsidx_index

### Tool Description
Index a sorted VCF file by rsID.

### Metadata
- **Docker Image**: quay.io/biocontainers/rsidx:0.3.1--pyhdfd78af_0
- **Homepage**: https://github.com/bioforensics/rsidx/
- **Package**: https://anaconda.org/channels/bioconda/packages/rsidx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rsidx index [-h] [-f] [-c C] [-m M] vcf idx

positional arguments:
  vcf                 sorted VCF file to index
  idx                 index file to create

options:
  -h, --help          show this help message and exit
  -f, --force         force overwrite of index file if it already exists
  -c, --cache-size C  modify default sqlite3 cache size (in KiB)
  -m, --mmap-size M   activate sqlite3 memory map mode and specify mmap_size
                      (in bytes)
```

## rsidx_search

### Tool Description
Search a sorted, indexed VCF file for rsIDs.

### Metadata
- **Docker Image**: quay.io/biocontainers/rsidx:0.3.1--pyhdfd78af_0
- **Homepage**: https://github.com/bioforensics/rsidx/
- **Package**: https://anaconda.org/channels/bioconda/packages/rsidx/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rsidx search [-h] [--header] [-o FILE] [--file] vcf idx rsid [rsid ...]

positional arguments:
  vcf             sorted and indexed VCF file
  idx             rsidx index file
  rsid            rsID(s) to search

options:
  -h, --help      show this help message and exit
  --header        print VCF headers
  -o, --out FILE  write output to specified FILE; default is terminal (stdout)
  --file          rsIDs are provided in a text file, one per line, rather than
                  as command line arguments
```

