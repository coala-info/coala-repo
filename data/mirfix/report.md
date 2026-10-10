# mirfix CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mirfix_MIRfix.py | Not completed | CWL fixed (writable family folder, mature and mapping copies, trailing slashes) and runs on the example family, but the example needs 15 large genome FASTA files; with a small substitute genome the Final.fasta matches the example except one precursor and no corrected alignment is made |

## mirfix_MIRfix.py

### Tool Description
MIRfix automatically curates miRNA datasets by improving alignments of their precursors, the consistency of the annotation of mature miR and miR* sequence, and the phylogenetic coverage. MIRfix produces alignments that are comparable across families and sets the stage for improved homology search as well as quantitative analyses.

### Metadata
- **Docker Image**: quay.io/biocontainers/mirfix:2.1.1--hdfd78af_0
- **Homepage**: https://github.com/Bierinformatik/MIRfix
- **Package**: https://anaconda.org/channels/bioconda/packages/mirfix/overview
- **Validation**: PASS

### Original Help Text
```text
usage: MIRfix.py [-h] [-j CORES] -f FAMILIES -i FAMDIR -g GENOMES -m MAPPING
                 -a MATURE [-d MATUREDIR] [-o OUTDIR] [--force] [-e EXTENSION]
                 [-l LOGDIR] [--loglevel {WARNING,ERROR,INFO,DEBUG,CRITICAL}]

MIRfix automatically curates miRNA datasets by improving alignments of their
precursors, the consistency of the annotation of mature miR and miR* sequence,
and the phylogenetic coverage. MIRfix produces alignments that are comparable
across families and sets the stage for improved homology search as well as
quantitative analyses.

optional arguments:
  -h, --help            show this help message and exit
  -j CORES, --cores CORES
                        Number of parallel processes to run
  -f FAMILIES, --families FAMILIES
                        Path to list of families to work on
  -i FAMDIR, --famdir FAMDIR
                        Directory where family files are located
  -g GENOMES, --genomes GENOMES
                        Genome FASTA files to parse
  -m MAPPING, --mapping MAPPING
                        Mapping between precursor and families
  -a MATURE, --mature MATURE
                        FASTA files containing mature sequences
  -d MATUREDIR, --maturedir MATUREDIR
                        Directory of matures
  -o OUTDIR, --outdir OUTDIR
                        Directory for output
  --force               Force MIRfix to overwrite existing output directories
  -e EXTENSION, --extension EXTENSION
                        Extension of nucleotides for precursor cutting
  -l LOGDIR, --logdir LOGDIR
                        Directory to write logfiles to
  --loglevel {WARNING,ERROR,INFO,DEBUG,CRITICAL}
                        Set log level
```


## Metadata
- **Skill**: generated
