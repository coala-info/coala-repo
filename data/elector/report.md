# elector CWL Generation Report

## elector

### Tool Description
elector is a tool for correcting long reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/elector:1.0.4--py312h719dbc0_5
- **Homepage**: https://github.com/kamimrcht/ELECTOR
- **Package**: https://anaconda.org/channels/bioconda/packages/elector/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/elector/overview
- **Total Downloads**: 21.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/kamimrcht/ELECTOR
- **Stars**: N/A
### Original Help Text
```text
usage: elector [-h] [-threads [THREADS]] [-corrected [CORRECTED]] [-split]
               [-uncorrected [UNCORRECTED]] [-perfect [PERFECT]]
               [-reference [REFERENCE]] [-simulator [SIMULATOR]]
               [-corrector [SOFT]] [-dazzDb [DAZZDB]]
               [-output [OUTPUTDIRPATH]] [-remap] [-assemble]
               [-minsize [MINSIZE]] [-noplot]

options:
  -h, --help            show this help message and exit
  -threads [THREADS]    Number of threads
  -corrected [CORRECTED]
                        Fasta file with corrected reads (each read sequence on
                        one line)
  -split                Corrected reads are split
  -uncorrected [UNCORRECTED]
                        Prefix of the reads simulation files
  -perfect [PERFECT]    Fasta file with reference read sequences (each read
                        sequence on one line)
  -reference [REFERENCE]
                        Fasta file with reference genome sequences (each
                        sequence on one line)
  -simulator [SIMULATOR]
                        Tool used for the simulation of the long reads (either
                        nanosim, simlord, or real). Value real should be used
                        if assessing real data.
  -corrector [SOFT]     Corrector used (lowercase, in this list: canu,
                        colormap, consent, daccord, ectools, flas, fmlrc,
                        halc, hercules, hg-color, jabba, lsc, lordec, lorma,
                        mecat, nas, nanocorr, pbdagcon, proovread). If no
                        corrector name is provided, make sure the read's
                        headers are correctly formatted (i.e. they correspond
                        to those of uncorrected and reference files)
  -dazzDb [DAZZDB]      Reads database used for the correction, if the reads
                        were corrected with Daccord or PBDagCon
  -output [OUTPUTDIRPATH]
                        Name for output directory
  -remap                Perform remapping of the corrected reads to the
                        reference
  -assemble             Perform assembly of the corrected reads
  -minsize [MINSIZE]    Do not assess reads/fragments chose length is <=
                        MINSIZE % of the original read
  -noplot               Do not output plots and PDF report with R/LaTeX
```

