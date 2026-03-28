# prosolo CWL Generation Report

## prosolo_control-fdr

### Tool Description
Filter calls for controlling the false discovery rate (FDR) at given level.

### Metadata
- **Docker Image**: quay.io/biocontainers/prosolo:0.6.1--h2138d71_0
- **Homepage**: https://github.com/PROSIC/prosolo/tree/v0.2.0
- **Package**: https://anaconda.org/channels/bioconda/packages/prosolo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/prosolo/overview
- **Total Downloads**: 34.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/PROSIC/prosolo
- **Stars**: N/A
### Original Help Text
```text
prosolo-control-fdr 
Filter calls for controlling the false discovery rate (FDR) at given level.

USAGE:
    prosolo control-fdr [OPTIONS] <BCF> --events <STRING(,STRING)*> --var <STRING>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -a, --fdr <alpha>                  FDR to control for. [default: 0.05]
    -e, --events <STRING(,STRING)*>    Comma-separated list of Events to consider jointly (e.g. `--events
                                       Event1,Event2`).
        --max-len <INT>                Maximum indel length to consider (exclusive).
        --min-len <INT>                Minimum indel length to consider.
    -o, --output <FILE>                BCF file that contains the filtered results (if omitted, write to STDOUT).
        --var <STRING>                 Variant type to consider (SNV, INS, DEL).

ARGS:
    <BCF>    Calls as provided by prosolo single-cell-bulk.
```


## prosolo_estimate-mutation-rate

### Tool Description
Estimate the effective mutation rate of a tumor sample from a VCF/BCF with candidate variants from STDIN.

### Metadata
- **Docker Image**: quay.io/biocontainers/prosolo:0.6.1--h2138d71_0
- **Homepage**: https://github.com/PROSIC/prosolo/tree/v0.2.0
- **Package**: https://anaconda.org/channels/bioconda/packages/prosolo/overview
- **Validation**: PASS

### Original Help Text
```text
prosolo-estimate-mutation-rate 
Estimate the effective mutation rate of a tumor sample from a VCF/BCF with candidate variants from STDIN.

USAGE:
    prosolo estimate-mutation-rate [OPTIONS]

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
        --fit <FILE>        Path to file that will contain observations and the parameters of the fitted model as JSON.
    -F, --max-af <FLOAT>    Maximum allele frequency to consider [0.25].
    -f, --min-af <FLOAT>    Minimum allele frequency to consider [0.12].
```


## prosolo_variants

### Tool Description
Prosolo variants tool

### Metadata
- **Docker Image**: quay.io/biocontainers/prosolo:0.6.1--h2138d71_0
- **Homepage**: https://github.com/PROSIC/prosolo/tree/v0.2.0
- **Package**: https://anaconda.org/channels/bioconda/packages/prosolo/overview
- **Validation**: PASS

### Original Help Text
```text
error: Found argument 'variants' which wasn't expected, or isn't valid in this context

USAGE:
    prosolo [FLAGS] <SUBCOMMAND>

For more information try --help
```


## prosolo_single-cell-bulk

### Tool Description
Call somatic and germline variants from a single cell-bulk sample pair and a VCF/BCF with candidate variants.

### Metadata
- **Docker Image**: quay.io/biocontainers/prosolo:0.6.1--h2138d71_0
- **Homepage**: https://github.com/PROSIC/prosolo/tree/v0.2.0
- **Package**: https://anaconda.org/channels/bioconda/packages/prosolo/overview
- **Validation**: PASS

### Original Help Text
```text
prosolo-single-cell-bulk 
Call somatic and germline variants from a single cell-bulk sample pair and a VCF/BCF with candidate variants.

USAGE:
    prosolo single-cell-bulk [FLAGS] [OPTIONS] <single-cell> <bulk> <reference>

FLAGS:
        --exclusive-end             Assume that the END tag is exclusive (i.e. it points to the position after the
                                    variant). This is needed, e.g., for DELLY.
    -h, --help                      Prints help information
        --omit-fragment-evidence    Omit evidence consisting of read pairs with unexpected insert size (insert size
                                    parameters will be ignored).
        --omit-indels               Don't call indels.
        --omit-snvs                 Don't call SNVs.
    -V, --version                   Prints version information

OPTIONS:
        --bulk-max-n <INT>                Maximum number of (theoretical) reads to work with in the bulk background, in
                                          case the actual read count for a variant is higher (all read information will
                                          be used, but probabilities will only be computed for all discrete allele
                                          frequencies allowed by the maximum read count provided here). The code will
                                          work with any number above bulk-min-n, but we use the cap of the currently
                                          used Lodato amplification bias model for the single cell sample as the
                                          default. [default: 100]
        --bulk-min-n <INT>                Minimum number of (theoretical) reads to work with in the bulk background, in
                                          case the actual read count for a variant site is lower (in this case,
                                          probabilities will be computed for all discrete allele frequencies allowed by
                                          the minimum read count provided here). The code will work with a minimum of 2,
                                          but for a more even sampling of Event spaces, the default is at 8. [default:
                                          8]
    -c, --candidates <FILE>               VCF/BCF file to process (if omitted, read from STDIN).
        --indel-window <INT>              Number of bases to consider left and right of indel breakpoint when
                                          calculating read support. This number should not be too large in order to
                                          avoid biases caused by other close variants. [default: 100]
        --max-indel-len <INT>             Omit longer indels when calling [1000].
        --obs <FILE>                      Optional path where read observations shall be written to. The resulting file
                                          contains a line for each observation with tab-separated values.
    -o, --output <FILE>                   BCF file that shall contain the results (if omitted, write to STDOUT).
        --pileup-window <INT>             Window to investigate for evidence left and right of each variant. [default:
                                          2500]
    -p, --ploidy <INT>                    General ploidy of sampled individual. [default: 2]
        --spurious-delext-rate <FLOAT>    Extension rate of spurious insertions by the sequencer (Illumina: 0.0, see
                                          Schirmer et al. BMC Bioinformatics 2016). [default: 0.0]
        --spurious-insext-rate <FLOAT>    Extension rate of spurious insertions by the sequencer (Illumina: 0.0, see
                                          Schirmer et al. BMC Bioinformatics 2016) [0.0]. [default: 0.0]
        --spurious-del-rate <FLOAT>       Rate of spuriosly deleted bases by the sequencer (Illumina: 5.1e-6, see
                                          Schirmer et al. BMC Bioinformatics 2016). [default: 5.1e-6]
        --spurious-ins-rate <FLOAT>       Rate of spuriously inserted bases by the sequencer (Illumina: 2.8e-6, see
                                          Schirmer et al. BMC Bioinformatics 2016). [default: 2.8e-6]

ARGS:
    <single-cell>    BAM file with reads from single cell sample.
    <bulk>           BAM file with reads from bulk sample.
    <reference>      FASTA file with reference genome. Has to be indexed with samtools faidx.
```


## prosolo_with

### Tool Description
ProSolo is a tool for processing and analyzing single-cell RNA sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/prosolo:0.6.1--h2138d71_0
- **Homepage**: https://github.com/PROSIC/prosolo/tree/v0.2.0
- **Package**: https://anaconda.org/channels/bioconda/packages/prosolo/overview
- **Validation**: PASS

### Original Help Text
```text
error: Found argument 'with' which wasn't expected, or isn't valid in this context

USAGE:
    prosolo [FLAGS] <SUBCOMMAND>

For more information try --help
```


## Metadata
- **Skill**: generated
