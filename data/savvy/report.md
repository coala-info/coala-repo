# savvy CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| savvy_sav_concat | Failed | tool bug: sav concat stops with 'Header dictionaries incompatible' even for two copies of the same SAV file; added the missing --out input |
| savvy_sav_export | PASS | Exported SAV back to VCF (24 records identical to the source) and sliced it into SAV parts; fixed command name sav |
| savvy_sav_head | PASS | Printed headers and sample IDs of the test SAV; contents match the source VCF |
| savvy_sav_import | PASS | Imported the savvy repo test_file.vcf into SAV; export back to VCF gives identical records; made input a required VCF/BCF file |
| savvy_sav_index | PASS | New CWL: wrote a separate .s1r index file and appended an index to a staged copy of a SAV file |
| savvy_sav_rehead | PASS | Replaced six sample IDs with S1 to S6; used the short -I option because the long --sample-ids option only prints usage |
| savvy_sav_sort | PASS | Sorted the test SAV in descending order; exported VCF starts at chr20 4236679; added the missing --output input |
| savvy_sav_stat | PASS | Counted records of the test SAV: 24 records, 28 variants, 4 multi-allelic; slices give 12 14 2 as expected |
| savvy_sav_stat-index | PASS | Printed per-chromosome index statistics (records 5 and 19) of the test SAV |
| savvy_sav_stat-merge | Not completed | new CWL: this stat prints only three counts, so there are no per-sample or per-count tables to merge; the merge output just repeats the first file, which cannot be confirmed |

## savvy_sav_import

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


## savvy_sav_export

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


## savvy_sav_concat

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


## savvy_sav_head

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


## savvy_sav_rehead

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


## savvy_sav_stat

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


## savvy_sav_stat-index

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


## savvy_sav_sort

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


## savvy_sav_index

### Tool Description
Indexes SAV file

### Metadata
- **Docker Image**: quay.io/biocontainers/savvy:2.1.0--h5b0a936_4
- **Homepage**: https://github.com/statgen/savvy
- **Package**: https://anaconda.org/channels/bioconda/packages/savvy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sav index [opts ...] <in.sav> 

 -h, --help    Print usage
 -o, --output  Output path (default: appends index to SAV file)
```

## savvy_sav_stat-merge

### Tool Description
Merges output from multiple calls to stat

### Metadata
- **Docker Image**: quay.io/biocontainers/savvy:2.1.0--h5b0a936_4
- **Homepage**: https://github.com/statgen/savvy
- **Package**: https://anaconda.org/channels/bioconda/packages/savvy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sav stat-merge [opts ...] <in1.tsv> <in2.tsv> [other.tsv ...] 

 -h, --help  Print usage
```

## Metadata
- **Skill**: generated
