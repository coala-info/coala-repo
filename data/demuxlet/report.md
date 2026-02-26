# demuxlet CWL Generation Report

## demuxlet

### Tool Description
Detailed instructions of parameters are available. Ones with "[]" are in effect:

### Metadata
- **Docker Image**: quay.io/biocontainers/demuxlet:1.0--h5ca1c30_7
- **Homepage**: https://github.com/statgen/demuxlet
- **Package**: https://anaconda.org/channels/bioconda/packages/demuxlet/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/demuxlet/overview
- **Total Downloads**: 7.2K
- **Last updated**: 2025-06-19
- **GitHub**: https://github.com/statgen/demuxlet
- **Stars**: N/A
### Original Help Text
```text
Detailed instructions of parameters are available. Ones with "[]" are in effect:

Available Options


Options for input SAM/BAM/CRAM
  --sam           [STR: ]             : Input SAM/BAM/CRAM file. Must be sorted by coordinates and indexed
  --tag-group     [STR: CB]           : Tag representing readgroup or cell barcodes, in the case to partition the BAM file into multiple groups. For 10x genomics, use CB
  --tag-UMI       [STR: UB]           : Tag representing UMIs. For 10x genomiucs, use UB

Options for input VCF/BCF
  --vcf           [STR: ]             : Input VCF/BCF file, containing the individual genotypes (GT), posterior probability (GP), or genotype likelihood (PL)
  --field         [STR: GP]           : FORMAT field to extract the genotype, likelihood, or posterior from
  --geno-error    [FLT: 0.01]         : Genotype error rate (must be used with --field GT)
  --min-mac       [INT: 1]            : Minimum minor allele frequency
  --min-callrate  [FLT: 0.50]         : Minimum call rate
  --sm            [V_STR: ]           : List of sample IDs to compare to (default: use all)
  --sm-list       [STR: ]             : File containing the list of sample IDs to compare

Output Options
  --out           [STR: ]             : Output file prefix
  --alpha         [V_FLT: ]           : Grid of alpha to search for (default is 0, 0.5)
  --write-pair    [FLG: OFF]          : Writing the (HUGE) pair file
  --doublet-prior [FLT: 0.50]         : Prior of doublet
  --sam-verbose   [INT: 1000000]      : Verbose message frequency for SAM/BAM/CRAM
  --vcf-verbose   [INT: 10000]        : Verbose message frequency for VCF/BCF

Read filtering Options
  --cap-BQ        [INT: 40]           : Maximum base quality (higher BQ will be capped)
  --min-BQ        [INT: 13]           : Minimum base quality to consider (lower BQ will be skipped)
  --min-MQ        [INT: 20]           : Minimum mapping quality to consider (lower MQ will be ignored)
  --min-TD        [INT: 0]            : Minimum distance to the tail (lower will be ignored)
  --excl-flag     [INT: 3844]         : SAM/BAM FLAGs to be excluded

Cell/droplet filtering options
  --group-list    [STR: ]             : List of tag readgroup/cell barcode to consider in this run. All other barcodes will be ignored. This is useful for parallelized run
  --min-total     [INT: 0]            : Minimum number of total reads for a droplet/cell to be considered
  --min-uniq      [INT: 0]            : Minimum number of unique reads (determined by UMI/SNP pair) for a droplet/cell to be considered
  --min-snp       [INT: 0]            : Minimum number of SNPs with coverage for a droplet/cell to be considered


NOTES:
When --help was included in the argument. The program prints the help message but do not actually run
```

