# aardvark CWL Generation Report

## aardvark_compare

### Tool Description
Core function for measuring a query VCF relative to a truth VCF

### Metadata
- **Docker Image**: quay.io/biocontainers/aardvark:0.10.4--h4349ce8_0
- **Homepage**: https://github.com/PacificBiosciences/aardvark
- **Package**: https://anaconda.org/channels/bioconda/packages/aardvark/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/aardvark/overview
- **Total Downloads**: 4.7K
- **Last updated**: 2026-01-28
- **GitHub**: https://github.com/PacificBiosciences/aardvark
- **Stars**: N/A
### Original Help Text
```text
Core function for measuring a query VCF relative to a truth VCF

Usage: aardvark compare [OPTIONS] --reference <FASTA> --truth-vcf <VCF> --query-vcf <VCF> --output-dir <DIR>

Options:
      --threads <THREADS>  Number of threads to use in the benchmarking step [default: 1]
  -v, --verbose...         Enable verbose output
  -h, --help               Print help
  -V, --version            Print version

Input/Output:
  -r, --reference <FASTA>      Reference FASTA file
  -t, --truth-vcf <VCF>        Truth variant call file (VCF)
  -q, --query-vcf <VCF>        Query variant call file (VCF)
  -b, --regions <BED>          Confidence regions (BED)
  -s, --stratification <TSV>   Stratifications, specifically the root file-of-filenames TSV
  -o, --output-dir <DIR>       Output directory containing summary and VCFs
      --output-debug <DIR>     Optional output debug folder
      --compare-label <LABEL>  Optional comparison label for the summary output [default: compare]
      --truth-sample <SAMPLE>  The sample name to use in the truth VCF [default: first sample]
      --query-sample <SAMPLE>  The sample name to use in the query VCF [default: first sample]

Region generation:
  --min-variant-gap <BP>      The minimum gap (bp) between variants to split into separate sub-regions [default: 50]
  --disable-variant-trimming  Disables variant trimming, which may have a negative impact on accuracy

Compare parameters:
  --max-branch-factor <INT>  Maximum branch factor in the query optimizer; limits work on dense variant regions [default: 50]

Optional metrics:
  --enable-haplotype-metrics           Enables the haplotype scoring metrics
  --enable-weighted-haplotype-metrics  Enables the weighted haplotype scoring metrics
  --enable-record-basepair-metrics     Enables the record-basepair scoring metrics

Copyright (C) 2004-2026     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## aardvark_merge

### Tool Description
Compares and merges variants from different VCF files

### Metadata
- **Docker Image**: quay.io/biocontainers/aardvark:0.10.4--h4349ce8_0
- **Homepage**: https://github.com/PacificBiosciences/aardvark
- **Package**: https://anaconda.org/channels/bioconda/packages/aardvark/overview
- **Validation**: PASS

### Original Help Text
```text
Compares and merges variants from different VCF files

Usage: aardvark merge [OPTIONS] --reference <FASTA> --input-vcf <VCF> --output-vcfs <DIR>

Options:
      --threads <THREADS>
          Number of threads to use in the benchmarking step
          
          [default: 1]

  -v, --verbose...
          Enable verbose output

  -h, --help
          Print help (see a summary with '-h')

  -V, --version
          Print version

Input/Output:
  -r, --reference <FASTA>
          Reference FASTA file

  -i, --input-vcf <VCF>
          Input variant call file (VCF), provided in priority order

  -s, --vcf-sample <SAMPLE>
          The sample name to use in the corresponding VCF [default: first sample]

  -t, --vcf-tag <SAMPLE>
          The annotation tag to use for the corresponding VCF [default: "vcf_#"]

  -b, --regions <BED>
          Regions to perform the merge (BED)

  -o, --output-vcfs <DIR>
          Output VCF folder

      --output-summary <TSV>
          Output summary file (CSV/TSV)

      --output-debug <DIR>
          Optional output debug folder

Region generation:
  --min-variant-gap <BP>
          The minimum gap (bp) between variants to split into separate sub-regions
          
          [default: 50]

  --disable-variant-trimming
          Disables variant trimming, which may have a negative impact on accuracy

Merge parameters:
  --merge-strategy <STRAT>
          Selects pre-set merge strategy for inclusion of a variant

          Possible values:
          - exact:       Must exactly match within the window for all samples
          - no_conflict: Must either exactly match or be missing completely from all samples; i.e., no conflicting variant calls
          - majority:    Allows for a majority to win even if others disagree
          - all:         Enables all optional merge strategies

  --enable-no-conflict
          Enables merging if no conflicts are detected

  --enable-voting
          Enables merging if the majority of inputs agree

  --conflict-select <INDEX>
          Sets a VCF index to select to always get selected in the event of conflict

  --max-branch-factor <INT>
          Maximum branch factor in the query optimizer; limits work on dense variant regions
          
          [default: 50]

Copyright (C) 2004-2026     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## Metadata
- **Skill**: not generated
