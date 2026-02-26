# maelstrom-core CWL Generation Report

## maelstrom-core_bam-collect-doc

### Tool Description
Create contigs with synthetic sequence

### Metadata
- **Docker Image**: quay.io/biocontainers/maelstrom-core:0.1.1--he3973ca_3
- **Homepage**: https://github.com/bihealth/maelstrom-core
- **Package**: https://anaconda.org/channels/bioconda/packages/maelstrom-core/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/maelstrom-core/overview
- **Total Downloads**: 2.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bihealth/maelstrom-core
- **Stars**: N/A
### Original Help Text
```text
maelstrom-core-bam-collect-doc 
Create contigs with synthetic sequence

USAGE:
    maelstrom-core bam-collect-doc [OPTIONS] --in <PATH_INPUT> --out <PATH_OUTPUT>

OPTIONS:
    -f, --force
            Force overwriting output file

    -h, --help
            Print help information

    -i, --in <PATH_INPUT>
            Path to input BAM file

    -k, --count-kind <COUNT_KIND>
            The coverage kind to count [default: coverage] [possible values: fragment-count,
            coverage]

        --min-mapq <MIN_MAPQ>
            Minimal MAPQ when collecting depth of coverage information

        --min-unclipped <MIN_UNCLIPPED>
            Minimal unclipped bases when collecting depth of coverage information

    -o, --out <PATH_OUTPUT>
            Path to output VCF/BCF file

    -q, --quiet
            Less output per occurrence

    -r, --reference <PATH_REFERENCE>
            Path to reference FASTA file

    -R, --regions <REGIONS>
            Optional list of regions to call

    -v, --verbose
            More output per occurrence

        --window-length <WINDOW_LENGTH>
            The window length [default: 1000]
```


## Metadata
- **Skill**: generated

## maelstrom-core

### Tool Description
Tools for processing of NGS data

### Metadata
- **Docker Image**: quay.io/biocontainers/maelstrom-core:0.1.1--he3973ca_3
- **Homepage**: https://github.com/bihealth/maelstrom-core
- **Package**: https://anaconda.org/channels/bioconda/packages/maelstrom-core/overview
- **Validation**: PASS
### Original Help Text
```text
maelstrom-core 0.1.1
Manuel Holtgrewe <manuel.holtgrewe@bih-charite.de>
Tools for processing of NGS data

USAGE:
    maelstrom-core [OPTIONS] <SUBCOMMAND>

OPTIONS:
    -h, --help       Print help information
    -q, --quiet      Less output per occurrence
    -v, --verbose    More output per occurrence
    -V, --version    Print version information

SUBCOMMANDS:
    bam-collect-doc    Create contigs with synthetic sequence
    help               Print this message or the help of the given subcommand(s)
```

