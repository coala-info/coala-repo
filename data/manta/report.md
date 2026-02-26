# manta CWL Generation Report

## manta_configManta.py

### Tool Description
This script configures the Manta SV analysis pipeline.
You must specify a BAM or CRAM file for at least one sample.

Configuration will produce a workflow run script which
can execute the workflow on a single node or through
sge and resume any interrupted execution.

### Metadata
- **Docker Image**: quay.io/biocontainers/manta:1.6.0--py27h9948957_6
- **Homepage**: https://github.com/Illumina/manta
- **Package**: https://anaconda.org/channels/bioconda/packages/manta/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/manta/overview
- **Total Downloads**: 112.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Illumina/manta
- **Stars**: N/A
### Original Help Text
```text
Usage: configManta.py [options]

Version: 1.6.0

This script configures the Manta SV analysis pipeline.
You must specify a BAM or CRAM file for at least one sample.

Configuration will produce a workflow run script which
can execute the workflow on a single node or through
sge and resume any interrupted execution.

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  --config=FILE         provide a configuration file to override defaults in
                        global config file (/usr/local/bin/configManta.py.ini)
  --allHelp             show all extended/hidden options

  Workflow options:
    --bam=FILE, --normalBam=FILE
                        Normal sample BAM or CRAM file. May be specified more
                        than once, multiple inputs will be treated as each BAM
                        file representing a different sample. [optional] (no
                        default)
    --tumorBam=FILE, --tumourBam=FILE
                        Tumor sample BAM or CRAM file. Only up to one tumor
                        bam file accepted. [optional] (no default)
    --exome             Set options for WES input: turn off depth filters
    --rna               Set options for RNA-Seq input. Must specify exactly
                        one bam input file
    --unstrandedRNA     Set if RNA-Seq input is unstranded: Allows splice-
                        junctions on either strand
    --referenceFasta=FILE
                        samtools-indexed reference fasta file [required]
    --runDir=DIR        Name of directory to be created where all workflow
                        scripts and output will be written. Each analysis
                        requires a separate directory. (default:
                        MantaWorkflow)
    --callRegions=FILE  Optionally provide a bgzip-compressed/tabix-indexed
                        BED file containing the set of regions to call. No VCF
                        output will be provided outside of these regions. The
                        full genome will still be used to estimate statistics
                        from the input (such as expected fragment size
                        distribution). Only one BED file may be specified.
                        (default: call the entire genome)

  Extended options (hidden):
```

