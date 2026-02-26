# cnvetti CWL Generation Report

## cnvetti_cmd

### Tool Description
Low-level access to the CNVetti primitives. This section of commands provides access to the individual, atomic steps of CNVetti.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvetti:0.2.0--he4cf2ce_0
- **Homepage**: https://github.com/bihealth/cnvetti
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvetti/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cnvetti/overview
- **Total Downloads**: 9.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bihealth/cnvetti
- **Stars**: N/A
### Original Help Text
```text
cnvetti-cmd 0.1.0
Low-level access to the CNVetti primitives.

USAGE:
    cnvetti cmd [OPTIONS] <SUBCOMMAND>

OPTIONS:
    -v, --verbose               Increase verbosity
    -q, --quiet                 Decrease verbosity
    -t, --io-threads <COUNT>    Number of additional threads to use for (de)compression in I/O. [default: 0]
    -h, --help                  Prints help information
    -V, --version               Prints version information

SUBCOMMANDS:
    coverage            Record coverage from input BAM file
    normalize           Normalize coverage on a per-sample level
    segment             Segment normalized coverage.
    merge-seg           Merge segmentation result files.
    genotype            Genotype calls from segmentation or calls and coverage BCF files.
    filter              Filter coverage information
    merge-cov           Merge the coverage information for multiple samples
    de-bias             Try to remove bias in the data
    build-model-pool    Build model based on pooling a reference panel.
    build-model-wis     Build within-sample model.
    mod-coverage        Compute coverage with information from a model.
    discover            Perform CNV discovery/calling.
    ratio               Compute the ratio between the coverages in two files.
    help                Prints this message or the help of the given subcommand(s)

This section of commands provides access to the individual, atomic steps of CNVetti.  You can use them to build your own
pipelines and themselves, they are used for implementing the shortcut commands.
```


## cnvetti_quick

### Tool Description
Easy-to-use shortcuts for command and important use cases.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvetti:0.2.0--he4cf2ce_0
- **Homepage**: https://github.com/bihealth/cnvetti
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvetti/overview
- **Validation**: PASS

### Original Help Text
```text
cnvetti-quick 0.1.0
Easy-to-use shortcuts for command and important use cases.

USAGE:
    cnvetti quick [OPTIONS] <SUBCOMMAND>

OPTIONS:
    -v, --verbose               Increase verbosity
    -q, --quiet                 Decrease verbosity
    -t, --io-threads <COUNT>    Number of additional threads to use for (de)compression in I/O. [default: 0]
    -h, --help                  Prints help information
    -V, --version               Prints version information

SUBCOMMANDS:
    wis-build-model     Build an within-sample model for targeted sequencing CNV calling.
    wis-call            Perform CNV calling on germline or unmatched tumor using within-sample approach.
    wis-call-matched    Perform CNV calling on one matched tumor sample using the within-sample approach.
    pool-build-model    Build a pool-based-sample model for targeted sequencing CNV calling.
    pool-call           Perform CNV calling on germline or unmatched tumor using pooling approach.
    help                Prints this message or the help of the given subcommand(s)
```


## cnvetti_visualize

### Tool Description
Visualization of coverage information (on-target, off-target, and genome-wide bins). This visualization command allows to extract coverage information tracks in IGV format from (target) coverage BCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvetti:0.2.0--he4cf2ce_0
- **Homepage**: https://github.com/bihealth/cnvetti
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvetti/overview
- **Validation**: PASS

### Original Help Text
```text
cnvetti-visualize 0.1.0
Visualization of coverage information (on-target, off-target, and genome-wide bins).

USAGE:
    cnvetti visualize [OPTIONS] <SUBCOMMAND>

OPTIONS:
    -v, --verbose               Increase verbosity
    -q, --quiet                 Decrease verbosity
    -t, --io-threads <COUNT>    Number of additional threads to use for (de)compression in I/O. [default: 0]
    -h, --help                  Prints help information
    -V, --version               Prints version information

SUBCOMMANDS:
    cov-to-igv    Build `.igv` visualization tracks from coverage BCF files.
    help          Prints this message or the help of the given subcommand(s)

This visualization command allows to extract coverage information tracks in IGV format from (target) coverage BCF files.
These files can then be convered into TDF format using `igvtools totdf FILE GENOME`.
```


## cnvetti_annotate

### Tool Description
Perform annotate called CNV result BCF files

### Metadata
- **Docker Image**: quay.io/biocontainers/cnvetti:0.2.0--he4cf2ce_0
- **Homepage**: https://github.com/bihealth/cnvetti
- **Package**: https://anaconda.org/channels/bioconda/packages/cnvetti/overview
- **Validation**: PASS

### Original Help Text
```text
cnvetti-annotate 0.1.0
Perform annotate called CNV result BCF files

USAGE:
    cnvetti annotate [OPTIONS]

OPTIONS:
    -v, --verbose               Increase verbosity
    -q, --quiet                 Decrease verbosity
    -t, --io-threads <COUNT>    Number of additional threads to use for (de)compression in I/O. [default: 0]
    -h, --help                  Prints help information
    -V, --version               Prints version information
```


## Metadata
- **Skill**: generated
