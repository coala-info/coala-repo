# savvy CWL Generation Report

## savvy_sav

### Tool Description
Missing sub-command

### Metadata
- **Docker Image**: quay.io/biocontainers/savvy:2.1.0--h5b0a936_4
- **Homepage**: https://github.com/statgen/savvy
- **Package**: https://anaconda.org/channels/bioconda/packages/savvy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/savvy/overview
- **Total Downloads**: 41.8K
- **Last updated**: 2025-09-08
- **GitHub**: https://github.com/statgen/savvy
- **Stars**: N/A
### Original Help Text
```text
Missing sub-command
Usage: sav <sub-command> [args ...]
or: sav [opts ...]

Sub-commands:
 export:      Exports SAV to VCF or SAV
 head:        Prints SAV headers or samples IDs
 import:      Imports VCF or BCF into SAV
 index:       Indexes SAV file
 rehead:      Replaces headers without recompressing variant blocks
 sort:        Sorts variant records
 stat:        Gathers statistics on SAV file
 stat-index:  Gathers statistics on s1r index
 stat-merge:  Merges output from multiple calls to stat

Options:
 -h, --help     Print usage
 -v, --version  Print version
```


## savvy_sav import

### Tool Description
Import data into SAV format

### Metadata
- **Docker Image**: quay.io/biocontainers/savvy:2.1.0--h5b0a936_4
- **Homepage**: https://github.com/statgen/savvy
- **Package**: https://anaconda.org/channels/bioconda/packages/savvy/overview
- **Validation**: PASS

### Original Help Text
```text
import: option '--h' is ambiguous; possibilities: '--headers' '--help'
Usage: sav import [opts ...] [in.sav] [out.{vcf,vcf.gz,sav}]

 -#                     Number (#) of compression level (1-19, default: 6)
 -b, --block-size       Number of markers in SAV compression block (0-65535, default: 4096)
 -c, --slice            Range formatted as begin:end (non-inclusive end) that specifies a subset of record offsets within file
 -f, --filter           Filter expression for including variants based on FILTER, QUAL, and INFO fields (eg, -f 'AC>=10;AF>0.01')
 -g, --generate-info    Generate info fields specified as a comma separated list (AC,MAC,AN,AF,MAF)
 -h, --help             Print usage
 -i, --sample-ids       Comma separated list of sample IDs to subset
 -I, --sample-ids-file  Path to file containing list of sample IDs to subset
 -p, --bounding-point   Determines the inclusion policy of indels during region queries (any, all, beg or end, default: beg)
 -r, --regions          Comma separated list of genomic regions formatted as chr[:start-end]
 -R, --regions-file     Path to file containing list of regions formatted as chr<tab>start<tab>end
 -X, --index-file       Specifies index output file (SAV output only)

     --phasing          Sets file phasing status if phasing header is not present (none, full, or partial)
     --pbwt-fields         Comma separated list of FORMAT fields for which to enable PBWT sorting
     --sparse-fields       Comma separated list of FORMAT fields to make sparse (default: GT,HDS,DS,EC)
     --sparse-threshold    Non-zero frequency threshold for which sparse fields are encoded as sparse vectors (default: 1.0)
     --update-info      Specifies whether AC, MAC, AN, AF and MAF info fields should be updated (always, never or auto, default: auto)
```


## savvy_sav export

### Tool Description
Export SAV data to VCF, VCF.GZ, or SAV format.

### Metadata
- **Docker Image**: quay.io/biocontainers/savvy:2.1.0--h5b0a936_4
- **Homepage**: https://github.com/statgen/savvy
- **Package**: https://anaconda.org/channels/bioconda/packages/savvy/overview
- **Validation**: PASS

### Original Help Text
```text
export: option '--h' is ambiguous; possibilities: '--headers' '--help'
Usage: sav export [opts ...] [in.sav] [out.{vcf,vcf.gz,sav}]

 -#                     Number (#) of compression level (1-19, default: 6)
 -b, --block-size       Number of markers in SAV compression block (0-65535, default: 4096)
 -c, --slice            Range formatted as begin:end (non-inclusive end) that specifies a subset of record offsets within file
 -f, --filter           Filter expression for including variants based on FILTER, QUAL, and INFO fields (eg, -f 'AC>=10;AF>0.01')
 -g, --generate-info    Generate info fields specified as a comma separated list (AC,MAC,AN,AF,MAF)
 -h, --help             Print usage
 -i, --sample-ids       Comma separated list of sample IDs to subset
 -I, --sample-ids-file  Path to file containing list of sample IDs to subset
 -O, --output-format    Output file format (vcf, vcf.gz or sav, default: vcf)
 -p, --bounding-point   Determines the inclusion policy of indels during region queries (any, all, beg or end, default: beg)
 -r, --regions          Comma separated list of genomic regions formatted as chr[:start-end]
 -R, --regions-file     Path to file containing list of regions formatted as chr<tab>start<tab>end
 -X, --index-file       Specifies index output file (SAV output only)

     --phasing          Sets file phasing status if phasing header is not present (none, full, or partial)
     --pbwt-fields         Comma separated list of FORMAT fields for which to enable PBWT sorting
     --sparse-fields       Comma separated list of FORMAT fields to make sparse (default: GT,HDS,DS,EC)
     --sparse-threshold    Non-zero frequency threshold for which sparse fields are encoded as sparse vectors (default: 1.0)
     --update-info      Specifies whether AC, MAC, AN, AF and MAF info fields should be updated (always, never or auto, default: auto)
```


## savvy_sav concat

### Tool Description
Concatenates SAV files.

### Metadata
- **Docker Image**: quay.io/biocontainers/savvy:2.1.0--h5b0a936_4
- **Homepage**: https://github.com/statgen/savvy
- **Package**: https://anaconda.org/channels/bioconda/packages/savvy/overview
- **Validation**: PASS

### Original Help Text
```text
Too few arguments
Usage: sav concat [opts ...] <first.sav> <second.sav> [addl_files.sav ...] 

 -h, --help             Print usage
 -o, --out              Output file (default: /dev/stdout)
```


## savvy_sav head

### Tool Description
Print headers or sample IDs from a Savvy file

### Metadata
- **Docker Image**: quay.io/biocontainers/savvy:2.1.0--h5b0a936_4
- **Homepage**: https://github.com/statgen/savvy
- **Package**: https://anaconda.org/channels/bioconda/packages/savvy/overview
- **Validation**: PASS

### Original Help Text
```text
Too few arguments
Usage: sav head [opts ...] <in.sav> 

 -h, --help           Print usage
 -i, --sample-ids     Print samples ids instead of headers
 -O, --output-format  Specifies output format for header lines (vcf or tsv; default: tsv)
```


## savvy_sav rehead

### Tool Description
Replace headers in a SAV file.

### Metadata
- **Docker Image**: quay.io/biocontainers/savvy:2.1.0--h5b0a936_4
- **Homepage**: https://github.com/statgen/savvy
- **Package**: https://anaconda.org/channels/bioconda/packages/savvy/overview
- **Validation**: PASS

### Original Help Text
```text
Too few arguments
Usage: sav rehead [opts ...] <headers_file> <in.sav> <out.sav> 
Or: sav rehead [opts ...] -i <sample_ids_file> <in.sav> <out.sav> 

 -h, --help         Print usage
 -I, --sample-ids   Path to file containing list of sample IDs that will replace existing IDs.
```


## savvy_sav stat

### Tool Description
Too few arguments

### Metadata
- **Docker Image**: quay.io/biocontainers/savvy:2.1.0--h5b0a936_4
- **Homepage**: https://github.com/statgen/savvy
- **Package**: https://anaconda.org/channels/bioconda/packages/savvy/overview
- **Validation**: PASS

### Original Help Text
```text
Too few arguments
Usage: sav stat [opts ...] <in.sav> 

 -h, --help  Print usage
```


## savvy_sav stat-index

### Tool Description
Index a SAV file for fast random access.

### Metadata
- **Docker Image**: quay.io/biocontainers/savvy:2.1.0--h5b0a936_4
- **Homepage**: https://github.com/statgen/savvy
- **Package**: https://anaconda.org/channels/bioconda/packages/savvy/overview
- **Validation**: PASS

### Original Help Text
```text
Too few arguments
Usage: sav stat-index [opts ...] <in.sav> 

 -h, --help  Print usage
```


## savvy_sav sort

### Tool Description
Sorts a SAV file.

### Metadata
- **Docker Image**: quay.io/biocontainers/savvy:2.1.0--h5b0a936_4
- **Homepage**: https://github.com/statgen/savvy
- **Package**: https://anaconda.org/channels/bioconda/packages/savvy/overview
- **Validation**: PASS

### Original Help Text
```text
Too few arguments
Usage: sav sort [opts ...] <in.sav> 

 -d, --direction   Specifies whether to sort in ascending or descending order (asc or desc; default: asc)
 -h, --help        Print usage
 -o, --output      Path to output SAV file (default: /dev/stdout).
 -p, --point       Specifies which allele position to sort by (beg, mid or end; default: beg)
```


## Metadata
- **Skill**: generated
