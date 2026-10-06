# bio-unicorn CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| bio-unicorn_bamstats | PASS |  |
| bio-unicorn_refstats | PASS |  |
| bio-unicorn_tidstats | PASS |  |

## bio-unicorn_refstats

### Tool Description
Compute per reference statistics such as # alignments, # reads, mean read length, etc.

### Metadata
- **Docker Image**: quay.io/biocontainers/bio-unicorn:2.0.0--h577a1d6_0
- **Homepage**: https://github.com/GeoGenetics/unicorn
- **Package**: https://anaconda.org/channels/bioconda/packages/bio-unicorn/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bio-unicorn/overview
- **Total Downloads**: 459
- **Last updated**: 2025-07-21
- **GitHub**: https://github.com/GeoGenetics/unicorn
- **Stars**: N/A
### Original Help Text
```text
./unicorn refstats [options] -b <in.bam>|<in.sam>|<in.cram>
Options:
  -b <str>   input bam|sam|cram
  -o <str>   output prefix
  --[FILTER] <PARAM>  Apply filter "FILTER" with parameter "PARAM"
      For example "--minreads 100" to filter out references with
      less than 100 reads.
      Available filters:
      - --minrefl  <int>  Minimum reference length to consider [0]
      - --minreads <int>  Minimum number of reads to consider  [1]
  -h         print this help message
unicorn 2.0.0 
	Jul 21 2025 20:06:52
```

## bio-unicorn_bamstats

### Tool Description
Compute per bam statistics.

### Metadata
- **Docker Image**: quay.io/biocontainers/bio-unicorn:2.0.0--h577a1d6_0
- **Homepage**: https://github.com/GeoGenetics/unicorn
- **Package**: https://anaconda.org/channels/bioconda/packages/bio-unicorn/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bio-unicorn/overview
- **Total Downloads**: 459
- **Last updated**: 2025-07-21
- **GitHub**: https://github.com/GeoGenetics/unicorn
- **Stars**: N/A
### Original Help Text
```text
./unicorn bamstats [options] -b <in.bam>|<in.sam>|<in.cram>
Options:
  -b <str>   input bam|sam|cram
  -o <str>   output prefix
  --filelist <str> File containing input file paths. One per line.
  --printdists     Print distributions of read lengths, alignment lengths, etc.
                   This will create a files <inputname>.dists.txt
unicorn 2.0.0 
	Jul 21 2025 20:06:52
```

## bio-unicorn_tidstats

### Tool Description
Compute per taxid statistics.

### Metadata
- **Docker Image**: quay.io/biocontainers/bio-unicorn:2.0.0--h577a1d6_0
- **Homepage**: https://github.com/GeoGenetics/unicorn
- **Package**: https://anaconda.org/channels/bioconda/packages/bio-unicorn/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bio-unicorn/overview
- **Total Downloads**: 459
- **Last updated**: 2025-07-21
- **GitHub**: https://github.com/GeoGenetics/unicorn
- **Stars**: N/A
### Original Help Text
```text
./unicorn tidstats [options] -b <in.bam>|<in.sam>|<in.cram>
Options:
  -b <str>   input bam|sam|cram
  -o <str>   output prefix
  -a <str> | --acc2tax <str>   Accession to taxid mapping file or .khash file.
                               Providing a .khash file is much faster.
  -n <str> | --names <str>   Taxonomy names file.
  -d <str> | --nodes <str>   Taxonomy nodes file
  --filelist <str> File containing input file paths. One per line.
  --dumpacc2tax <str> Write the accession to taxid map to <str>.khash.
  --verbose           Prints libunicorn's messages.
  -h         print this help message
unicorn 2.0.0 
	Jul 21 2025 20:06:52
```
