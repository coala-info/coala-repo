# prosic CWL Generation Report

## prosic_call-tumor-normal

### Tool Description
Call somatic and germline variants from a tumor-normal sample pair and a VCF/BCF with candidate variants.

### Metadata
- **Docker Image**: quay.io/biocontainers/prosic:2.1.2--hc7800f0_1
- **Homepage**: https://prosic.github.io
- **Package**: https://anaconda.org/channels/bioconda/packages/prosic/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/prosic/overview
- **Total Downloads**: 22.7K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
prosic-call-tumor-normal 
Call somatic and germline variants from a tumor-normal sample pair and a VCF/BCF with candidate variants.

USAGE:
    prosic call-tumor-normal [FLAGS] [OPTIONS] <tumor> <normal> <reference>

FLAGS:
        --exclusive-end             Assume that the END tag is exclusive (i.e. it points to the position after the
                                    variant). This is needed, e.g., for DELLY.
        --flat-priors               Ignore the prior model and use flat priors instead.
    -h, --help                      Prints help information
        --omit-fragment-evidence    Omit evidence consisting of read pairs with unexpected insert size (insert size
                                    parameters will be ignored).
        --omit-indels               Don't call indels.
        --omit-snvs                 Don't call SNVs.
    -V, --version                   Prints version information

OPTIONS:
    -c, --candidates <FILE>               VCF/BCF file to process (if omitted, read from STDIN).
    -d, --deletion-factor <FLOAT>         Factor of deletion mutation rate relative to SNV mutation rate (0.03 according
                                          to Hodkinson et al. Nature Reviews Genetics 2011). [default: 0.03]
        --effmut <FLOAT>                  Effective SNV mutation rate of tumor sample (should be estimated from somatic
                                          SNVs). [default: 2000.0]
        --het <FLOAT>                     Expected heterozygosity of normal sample. [default: 1.25E-4]
        --indel-window <INT>              Number of bases to consider left and right of indel breakpoint when
                                          calculating read support. This number should not be too large in order to
                                          avoid biases caused by other close variants. [default: 100]
    -i, --insertion-factor <FLOAT>        Factor of insertion mutation rate relative to SNV mutation rate (0.01
                                          according to Hodkinson et al. Nature Reviews Genetics 2011). [default: 0.01]
        --max-indel-len <INT>             Omit longer indels when calling. [default: 1000]
        --obs <FILE>                      Optional path where read observations shall be written to. The resulting file
                                          contains a line for each observation with tab-separated values.
    -o, --output <FILE>                   BCF file that shall contain the results (if omitted, write to STDOUT).
        --pileup-window <INT>             Window to investigate for evidence left and right of each variant. [default:
                                          2500]
    -p, --ploidy <INT>                    Average ploidy of tumor and normal sample. [default: 2]
        --spurious-delext-rate <FLOAT>    Extension rate of spurious insertions by the sequencer (Illumina: 0.0, see
                                          Schirmer et al. BMC Bioinformatics 2016). [default: 0.0]
        --spurious-insext-rate <FLOAT>    Extension rate of spurious insertions by the sequencer (Illumina: 0.0, see
                                          Schirmer et al. BMC Bioinformatics 2016) [0.0]. [default: 0.0]
        --spurious-del-rate <FLOAT>       Rate of spuriosly deleted bases by the sequencer (Illumina: 5.1e-6, see
                                          Schirmer et al. BMC Bioinformatics 2016). [default: 5.1e-6]
        --spurious-ins-rate <FLOAT>       Rate of spuriously inserted bases by the sequencer (Illumina: 2.8e-6, see
                                          Schirmer et al. BMC Bioinformatics 2016). [default: 2.8e-6]
    -r, --spurious-isize-rate <FLOAT>     Rate of wrongly reported insert size abberations (should be set depending on
                                          mapper, BWA: 0.01332338, LASER: 0.05922201). [default: 0.0]
    -a, --purity <FLOAT>                  Purity of tumor sample. [default: 1.0]

ARGS:
    <tumor>        BAM file with reads from tumor sample.
    <normal>       BAM file with reads from normal sample.
    <reference>    FASTA file with reference genome. Has to be indexed with samtools faidx.
```


## prosic_candidate

### Tool Description
prosic

### Metadata
- **Docker Image**: quay.io/biocontainers/prosic:2.1.2--hc7800f0_1
- **Homepage**: https://prosic.github.io
- **Package**: https://anaconda.org/channels/bioconda/packages/prosic/overview
- **Validation**: PASS

### Original Help Text
```text
error: Found argument 'candidate' which wasn't expected, or isn't valid in this context

USAGE:
    prosic [FLAGS] <SUBCOMMAND>

For more information try --help
```


## prosic_control-fdr

### Tool Description
Filter calls for controlling the false discovery rate (FDR) at given level.

### Metadata
- **Docker Image**: quay.io/biocontainers/prosic:2.1.2--hc7800f0_1
- **Homepage**: https://prosic.github.io
- **Package**: https://anaconda.org/channels/bioconda/packages/prosic/overview
- **Validation**: PASS

### Original Help Text
```text
prosic-control-fdr 
Filter calls for controlling the false discovery rate (FDR) at given level.

USAGE:
    prosic control-fdr [OPTIONS] <BCF>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -a, --fdr <alpha>       FDR to control for. [default: 0.05]
    -e, --event <STRING>    Event to consider.
        --max-len <INT>     Maximum indel length to consider (exclusive).
        --min-len <INT>     Minimum indel length to consider.
        --var <STRING>      Variant type to consider (SNV, INS, DEL).

ARGS:
    <BCF>    Calls as provided by prosic tumor-normal.
```


## prosic_estimate-mutation-rate

### Tool Description
Estimate the effective mutation rate of a tumor sample from a VCF/BCF with candidate variants from STDIN.

### Metadata
- **Docker Image**: quay.io/biocontainers/prosic:2.1.2--hc7800f0_1
- **Homepage**: https://prosic.github.io
- **Package**: https://anaconda.org/channels/bioconda/packages/prosic/overview
- **Validation**: PASS

### Original Help Text
```text
prosic-estimate-mutation-rate 
Estimate the effective mutation rate of a tumor sample from a VCF/BCF with candidate variants from STDIN.

USAGE:
    prosic estimate-mutation-rate [OPTIONS]

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
        --fit <FILE>        Path to file that will observations and the parameters of the fitted model as JSON.
    -F, --max-af <FLOAT>    Maximum allele frequency to consider [0.25].
    -f, --min-af <FLOAT>    Minimum allele frequency to consider [0.12].
```


## prosic_variants

### Tool Description
ProSIc: a tool for predicting the impact of variants on protein stability

### Metadata
- **Docker Image**: quay.io/biocontainers/prosic:2.1.2--hc7800f0_1
- **Homepage**: https://prosic.github.io
- **Package**: https://anaconda.org/channels/bioconda/packages/prosic/overview
- **Validation**: PASS

### Original Help Text
```text
error: Found argument 'variants' which wasn't expected, or isn't valid in this context

USAGE:
    prosic [FLAGS] <SUBCOMMAND>

For more information try --help
```


## Metadata
- **Skill**: generated
