# methbat CWL Generation Report

## methbat_build

### Tool Description
Build a background/cohort profile from a collection of profiles

### Metadata
- **Docker Image**: quay.io/biocontainers/methbat:0.17.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/MethBat
- **Package**: https://anaconda.org/channels/bioconda/packages/methbat/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/methbat/overview
- **Total Downloads**: 3.7K
- **Last updated**: 2025-12-02
- **GitHub**: https://github.com/PacificBiosciences/MethBat
- **Stars**: N/A
### Original Help Text
```text
Build a background/cohort profile from a collection of profiles

Usage: methbat build --input-collection <FILE> --output-profile <FILE>

Options:
  -h, --help     Print help
  -V, --version  Print version

Input/Output:
  -i, --input-collection <FILE>  Input file defining a cohort to load into a background profile (CSV/TSV)
  -o, --output-profile <FILE>    Output background profile (CSV/TSV)

Copyright (C) 2004-2026     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## methbat_compare

### Tool Description
Compare sub-groups in a background/cohort profile

### Metadata
- **Docker Image**: quay.io/biocontainers/methbat:0.17.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/MethBat
- **Package**: https://anaconda.org/channels/bioconda/packages/methbat/overview
- **Validation**: PASS

### Original Help Text
```text
Compare sub-groups in a background/cohort profile

Usage: methbat compare [OPTIONS] --input-profile <FILE> --output-comparison <FILE> --compare-category <VALUE>

Options:
  -h, --help     Print help
  -V, --version  Print version

Input/Output:
  -i, --input-profile <FILE>       Input cohort/background profile (CSV/TSV)
  -o, --output-comparison <FILE>   Output comparison file (CSV/TSV)
  -b, --baseline-category <VALUE>  The baseline category to compare against, all outputs are relative to baseline [default: ALL]
  -c, --compare-category <VALUE>   The category we are using as the comparator to baseline

Comparison thresholds:
      --min-zscore <Z>       The minimum absolute Z-score deviation between the baseline and comparator to assign a label [default: 3.0]
      --min-delta <DELTA>    The minimum absolute delta between the baseline and comparator to assign a label [default: 0.2]
      --min-samples <COUNT>  The minimum sample count required in both baseline and comparator to assign a label [default: 10]

Copyright (C) 2004-2026     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## methbat_deconvolve

### Tool Description
Perform cell-type deconvolution based on an atlas

### Metadata
- **Docker Image**: quay.io/biocontainers/methbat:0.17.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/MethBat
- **Package**: https://anaconda.org/channels/bioconda/packages/methbat/overview
- **Validation**: PASS

### Original Help Text
```text
Perform cell-type deconvolution based on an atlas

Usage: methbat deconvolve [OPTIONS] --input-prefix <PREFIX> --atlas-regions <FILE> --output-estimate <FILE>

Options:
  -h, --help     Print help
  -V, --version  Print version

Input/Output:
  -i, --input-prefix <PREFIX>   Input prefix from pb-CpG-tools
  -a, --atlas-regions <FILE>    Input atlas regions (CSV/TSV)
  -o, --output-estimate <FILE>  Output summary file from deconvolution estimates (JSON)

Deconvolution:
      --min-active <FLOAT>  Minimum active proportion threshold for cell type filtering [default: 0.05]

Copyright (C) 2004-2026     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## methbat_joint-segment

### Tool Description
Jointly segments a collection a samples into common methylation types

### Metadata
- **Docker Image**: quay.io/biocontainers/methbat:0.17.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/MethBat
- **Package**: https://anaconda.org/channels/bioconda/packages/methbat/overview
- **Validation**: PASS

### Original Help Text
```text
Jointly segments a collection a samples into common methylation types

Usage: methbat joint-segment [OPTIONS] --input-collection <FILE> --output-prefix <PREFIX>

Options:
  -t, --threads <THREADS>  Number of threads to use for signature building [default: 1]
  -h, --help               Print help
  -V, --version            Print version

Input/Output:
  -i, --input-collection <FILE>  Input file defining a cohort to load into a background profile (CSV/TSV)
  -o, --output-prefix <PREFIX>   Output prefix
      --condense-bed-labels      Condenses the labels of output BED regions to abbreviated representations

Filtering:
      --min-sample-frac <FRAC>  The minimum sample fraction required to include a CpG [default: 0.9]
      --min-asm-frac <FRAC>     The minimum haplotagged fraction required to include ASM for a CpG [default: 0.6]

Segmentation:
      --enable-nodata-segments    Enables the output of NoData haplotype segments
      --target-confidence <FRAC>  The target confidence level [default: 0.99]
      --min-abs-zscore <Z>        The minimum absolute Z-score to split a segment, overrides --target-confidence
      --min-cpgs <COUNT>          The minimum number of CpGs that can form a segment [default: 20]
      --max-gap <BASEPAIRS>       The maximum gap allowed between CpGs before they are automatically segmented [default: 1000]

Segment Categorization:
      --min-asm-abs-delta-mean <DELTA>
          The minimum absolute difference between mean haplotype methylation fractions to consider ASM [default: 0.5]
      --max-unmethylated-combined <FRAC>
          The maximum combined methylation fraction to consider unmethylated status [default: 0.2]
      --min-methylated-combined <FRAC>
          The minimum combined methylation fraction to consider methylated status [default: 0.8]

Copyright (C) 2004-2026     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## methbat_profile

### Tool Description
Create a CpG profile for a single dataset from pb-CpG-tools output

### Metadata
- **Docker Image**: quay.io/biocontainers/methbat:0.17.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/MethBat
- **Package**: https://anaconda.org/channels/bioconda/packages/methbat/overview
- **Validation**: PASS

### Original Help Text
```text
Create a CpG profile for a single dataset from pb-CpG-tools output

Usage: methbat profile [OPTIONS] --input-prefix <PREFIX>

Options:
  -h, --help     Print help
  -V, --version  Print version

Input/Output:
  -i, --input-prefix <PREFIX>         Input prefix from pb-CpG-tools
  -r, --input-regions <FILE>          Optional input regions or background profile for CpG aggregation (CSV/TSV)
  -o, --output-region-profile <FILE>  Optional output CpG aggregation file (CSV/TSV)
      --output-asm-bed <BED>          Optional output BED file with individual ASM CpG loci

Region analysis:
      --profile-label <LABEL>
          Specify the label from the background profile to compare against, can be specified multiple times [default: ALL]
      --min-asm-phased-fraction <FRAC>
          The minimum fraction of CpGs in a region that must be phased to consider ASM [default: 0.75]
      --min-asm-abs-delta-mean <DELTA>
          The minimum absolute difference between mean haplotype methylation fractions to consider ASM [default: 0.5]
      --max-asm-fishers-exact <P-VALUE>
          The maximum Fisher's exact test p-value to consider ASM [default: 0.01]
      --max-unmethylated-combined <FRAC>
          The maximum combined methylation fraction to consider unmethylated status [default: 0.2]
      --min-methylated-combined <FRAC>
          The minimum combined methylation fraction to consider methylated status [default: 0.8]

Background comparison:
      --min-abs-zscore <Z>     The minimum absolute Z-score to flag a region as Hypo-/Hyper- relative to the background population [default: 3.0]
      --min-abs-delta <DELTA>  The minimum absolute delta from mean to flag a region as Hypo-/Hyper- relative to the background population [default: 0.2]
      --min-datasets <COUNT>   The minimum number of background dataset required to flag a region Hypo-/Hyper- relative to the background population; ASM requires this many phased datasets [default: 10]

Allele-specific methylation:
      --p-value <P-VALUE>  ASM p-value cutoff for --output-asm-bed [default: 0.05]

Copyright (C) 2004-2026     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## methbat_report

### Tool Description
Generate a report for a single dataset from pb-CpG-tools output

### Metadata
- **Docker Image**: quay.io/biocontainers/methbat:0.17.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/MethBat
- **Package**: https://anaconda.org/channels/bioconda/packages/methbat/overview
- **Validation**: PASS

### Original Help Text
```text
Generate a report for a single dataset from pb-CpG-tools output

Usage: methbat report [OPTIONS] --input-prefix <PREFIX> --input-regions <FILE> --output-report <FILE>

Options:
  -h, --help     Print help
  -V, --version  Print version

Input/Output:
  -i, --input-prefix <PREFIX>  Input prefix from pb-CpG-tools
  -r, --input-regions <FILE>   Input regions to report (CSV/TSV)
  -o, --output-report <FILE>   Output report file (CSV/TSV)

Labeling heuristics:
      --min-haplotype-coverage <COVERAGE>
          The minimum coverage of a haplotype to consider it "normal" for QC purposes [default: 10]
      --min-asm-phased-fraction <FRAC>
          The minimum fraction of CpGs in a region that must be phased to consider ASM [default: 0.75]
      --min-asm-abs-delta-mean <DELTA>
          The minimum absolute difference between mean haplotype methylation fractions to consider ASM [default: 0.5]
      --min-weakasm-abs-delta-mean <DELTA>
          The minimum absolute difference between mean haplotype methylation fractions to consider Weak ASM [default: 0.3]
      --max-asm-fishers-exact <P-VALUE>
          The maximum Fisher's exact test p-value to consider ASM [default: 0.01]
      --max-unmethylated-combined <FRAC>
          The maximum combined methylation fraction to consider unmethylated status [default: 0.2]
      --min-methylated-combined <FRAC>
          The minimum combined methylation fraction to consider methylated status [default: 0.8]

Copyright (C) 2004-2026     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## methbat_segment

### Tool Description
Segments the output from pb-CpG-tools

### Metadata
- **Docker Image**: quay.io/biocontainers/methbat:0.17.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/MethBat
- **Package**: https://anaconda.org/channels/bioconda/packages/methbat/overview
- **Validation**: PASS

### Original Help Text
```text
Segments the output from pb-CpG-tools

Usage: methbat segment [OPTIONS] --input-prefix <PREFIX> --output-prefix <PREFIX>

Options:
  -h, --help     Print help
  -V, --version  Print version

Input/Output:
  -i, --input-prefix <PREFIX>   Input prefix from pb-CpG-tools
  -o, --output-prefix <PREFIX>  Prefix for output files
      --condense-bed-labels     Condenses the labels of output BED regions to abbreviated representations

Segmentation:
      --enable-haplotype-segmentation  Enables the segmentation of individual haplotypes
      --enable-nodata-segments         Enables the output of NoData haplotype segments
      --target-confidence <FRAC>       The target confidence level [default: 0.99]
      --min-abs-zscore <Z>             The minimum absolute Z-score to split a segment, overrides --target-confidence
      --min-cpgs <COUNT>               The minimum number of CpGs that can form a segment [default: 20]
      --max-gap <BASEPAIRS>            The maximum gap allowed between CpGs before they are automatically segmented [default: 1000]

Segment Categorization:
      --min-asm-abs-delta-mean <DELTA>
          The minimum absolute difference between mean haplotype methylation fractions to consider ASM [default: 0.5]
      --max-unmethylated-combined <FRAC>
          The maximum combined methylation fraction to consider unmethylated status [default: 0.2]
      --min-methylated-combined <FRAC>
          The minimum combined methylation fraction to consider methylated status [default: 0.8]

Copyright (C) 2004-2026     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## methbat_signature

### Tool Description
Identify signature regions distinguishing cases from controls

### Metadata
- **Docker Image**: quay.io/biocontainers/methbat:0.17.0--h9ee0642_0
- **Homepage**: https://github.com/PacificBiosciences/MethBat
- **Package**: https://anaconda.org/channels/bioconda/packages/methbat/overview
- **Validation**: PASS

### Original Help Text
```text
Identify signature regions distinguishing cases from controls

Usage: methbat signature [OPTIONS] --input-collection <FILE> --output-prefix <PREFIX>

Options:
  -t, --threads <THREADS>  Number of threads to use for signature building [default: 1]
  -h, --help               Print help
  -V, --version            Print version

Input/Output:
  -i, --input-collection <FILE>    Input file defining a cohort to load into the signature
  -o, --output-prefix <PREFIX>     Output prefix
  -b, --baseline-category <VALUE>  The baseline category to compare against, all outputs are relative to baseline [default: control]
  -c, --compare-category <VALUE>   The category we are using as the comparator to baseline [default: case]

Comparison thresholds:
      --min-sample-frac <COUNT>  The minimum sample fraction required in both baseline and comparator to assess a region [default: 0.8]
      --min-zscore <Z>           The minimum absolute Z-score deviation between the baseline and comparator to consider a region for the signature [default: 5.0]
      --min-delta <DELTA>        The minimum average delta between the baseline and comparator to consider a region for the signature [default: 0.2]

Segmentation:
      --target-confidence <FRAC>  The target confidence level [default: 0.99]
      --min-abs-zscore <Z>        The minimum absolute Z-score to split a segment, overrides --target-confidence
      --min-cpgs <COUNT>          The minimum number of CpGs that can form a segment [default: 10]
      --max-gap <BASEPAIRS>       The maximum gap allowed between CpGs before they are automatically segmented [default: 1000]

Copyright (C) 2004-2026     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## Metadata
- **Skill**: generated
