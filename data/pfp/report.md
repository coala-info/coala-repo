# pfp CWL Generation Report

## pfp

### Tool Description
FAIL to generate CWL: pfp not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/pfp:0.3.9--h20648a7_3
- **Homepage**: https://github.com/marco-oliva/pfp
- **Package**: https://anaconda.org/channels/bioconda/packages/pfp/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/pfp/overview
- **Total Downloads**: 11.5K
- **Last updated**: 2025-08-19
- **GitHub**: https://github.com/marco-oliva/pfp
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: pfp not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: pfp not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## pfp_pfp++

### Tool Description
PFP++: A tool for parsing and processing genomic data using Prefix-Free Parsing.

### Metadata
- **Docker Image**: quay.io/biocontainers/pfp:0.3.9--h20648a7_3
- **Homepage**: https://github.com/marco-oliva/pfp
- **Package**: https://anaconda.org/channels/bioconda/packages/pfp/overview
- **Validation**: PASS
### Original Help Text
```text
PFP++
Usage: /usr/local/bin/pfp++ [OPTIONS]

Options:
  -h,--help                   Print this help message and exit
  -v,--vcf TEXT ...           List of comma ',' separated vcf files. Assuming in genome order!
  -r,--ref TEXT ...           List of comma ',' separated reference files. Assuming in genome order!
  -f,--fasta TEXT:FILE        Fasta file to parse.
  -i,--int32t TEXT:FILE       Integers file to parse.
  --int-shift UINT:INT in [0 - 200]
                              Each integer i in int32t input is interpreted as (i + int-shift).
  -H,--haplotype TEXT         Haplotype: [1,2,12].
  -t,--text TEXT:FILE         Text file to parse.
  -o,--out-prefix TEXT        Output prefix.
  -m,--max UINT               Max number of samples to analyze.
  -S,--samples TEXT           File containing the list of samples to parse.
  -w,--window-size UINT:INT in [3 - 200]
                              Sliding window size.
  -p,--modulo UINT:INT in [5 - 20000]
                              Modulo used during parsing.
  -j,--threads UINT           Number of threads.
  --tmp-dir TEXT:DIR          Temporary files directory.
  -c,--compress-dictionary    Also output compressed the dictionary.
  --use-vcf-acceleration      Use reference parse to avoid re-parsing.
  --print-statistics          Print out csv containing stats.
  --output-occurrences        Output count for each dictionary phrase.
  --output-sai                Output sai array.
  --output-last               Output last array.
  --acgt-only                 Convert all non ACGT characters from a VCF or FASTA file to N.
  --verbose                   Verbose output.
  --version                   Version number.
  --configure                 Read an ini file

[Disk Write (bytes): 0]
```

