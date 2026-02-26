# variantbam CWL Generation Report

## variantbam_variant

### Tool Description
Filter a BAM/SAM/CRAM/STDIN according to hierarchical rules

### Metadata
- **Docker Image**: quay.io/biocontainers/variantbam:1.4.3--0
- **Homepage**: https://github.com/jwalabroad/VariantBam
- **Package**: https://anaconda.org/channels/bioconda/packages/variantbam/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/variantbam/overview
- **Total Downloads**: 39.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jwalabroad/VariantBam
- **Stars**: N/A
### Original Help Text
```text
Usage: variant <input.bam> [OPTIONS] 

  Description: Filter a BAM/SAM/CRAM/STDIN according to hierarchical rules

 General options
  -h, --help                           Display this help and exit
  -v, --verbose                        Verbose output
  -x, --no-output                      Don't output reads (used for profiling with -q)
  -r, --rules                          JSON ecript for the rules.
  -k, --proc-regions-file              Samtools-style region string (e.g. 1:1,000-2,000) or BED/VCF of regions to process. -k UN iterates over unmapped-unmapped reads
 Output options
  -o, --output                         Output file to write to (BAM/SAM/CRAM) file instead of stdout
  -C, --cram                           Output file should be in CRAM format
  -b, --bam                            Output should be in binary BAM format
  -T, --reference                      Path to reference. Required for reading/writing CRAM
  -s, --strip-tags                     Remove the specified tags, separated by commas. eg. -s RG,MD
  -S, --strip-all-tags                 Remove all alignment tags
      --write-trimmed                  Output the base-quality trimmed sequence rather than the original sequence. Also removes quality scores
 Filtering options
  -q, --qc-file                        Output a qc file that contains information about BAM
  -m, --max-coverage                   Maximum coverage of output file. BAM must be sorted. Negative values enforce a minimum coverage
  -p, --min-phred                      Set the minimum base quality score considered to be high-quality
 Region specifiers
  -g, --region                         Regions (e.g. myvcf.vcf or WG for whole genome) or newline seperated subsequence file.
  -G, --exclude-region                 Same as -g, but for region where satisfying a rule EXCLUDES this read.
  -l, --linked-region                  Same as -g, but turns on mate-linking
  -L, --linked-exclude-region          Same as -l, but for mate-linked region where satisfying this rule EXCLUDES this read.
  -P, --region-pad                     Apply a padding to each region supplied with the region flags (specify after region flag)
 Command line rules shortcuts (to be used without supplying a -r script)
      --min-clip                       Minimum number of quality clipped bases
      --max-nbases                     Maximum number of N bases
      --min-mapq                       Minimum mapping quality
      --min-del                        Minimum number of deleted bases
      --min-ins                        Minimum number of inserted bases
      --min-length                     Minimum read length (after base-quality trimming)
      --motif                          Motif file
  -R, --read-group                     Limit to just a single read group
  -f, --include-aln-flag               Flags to include (like samtools -f)
  -F, --exclude-aln-flag               Flags to exclude (like samtools -F)
```

