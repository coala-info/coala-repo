# var-agg CWL Generation Report

## var-agg

### Tool Description
Aggregatation of multi-sample VCF files into site VCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/var-agg:0.1.1--h2c42bab_0
- **Homepage**: https://github.com/bihealth/var-agg
- **Package**: https://anaconda.org/channels/bioconda/packages/var-agg/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/var-agg/overview
- **Total Downloads**: 10.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bihealth/var-agg
- **Stars**: N/A
### Original Help Text
```text
var-agg 0.1.0
Manuel Holtgrewe <manuel.holtgrewe@bihealth.de>
Aggregatation of multi-sample VCF files into site VCF files.

USAGE:
    var-agg [OPTIONS] <INPUT.<vcf|bcf>>... --output <OUT.<vcf|bcf>>

OPTIONS:
    -v, --verbose                         Increase verbosity
    -q, --quiet                           Decrease verbosity
    -t, --io-threads <COUNT>              Number of additional threads to use for (de)compression in I/O. [default: 0]
    -o, --output <OUT.<vcf|bcf>>          Path to output VCF/BCF file to create. Will also write out a CSI/TBI index.
        --input-panel <INPUT.panel>...    Path to panel file, format is "SAMPLE<tab>SUB-
                                          POPULATION<tab>POPULATION<ignored>"
        --input-ped <INPUT.ped>...        Path to input PED file for FOUND_* INFO entries.
        --input-fasta <INPUT.fa>...       FAI-indexed reference FASTA file, only index will be accessed.
    -h, --help                            Prints help information
    -V, --version                         Prints version information

ARGS:
    <INPUT.<vcf|bcf>>...    Path to VCF/BCF file(s) to read.
```


## Metadata
- **Skill**: generated
