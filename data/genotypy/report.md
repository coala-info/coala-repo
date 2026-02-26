# genotypy CWL Generation Report

## genotypy

### Tool Description
Detect genomic barcodes from a given set of reads in a set of defined loci where those barcodes can be expected.

### Metadata
- **Docker Image**: quay.io/biocontainers/genotypy:0.3.4--pyhdfd78af_0
- **Homepage**: https://gitbio.ens-lyon.fr/LBMC/yvertlab/vortex/plasticity_mutation/colony_rnaseq_bioinformatics/genotypy
- **Package**: https://anaconda.org/channels/bioconda/packages/genotypy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/genotypy/overview
- **Total Downloads**: 544
- **Last updated**: 2025-05-14
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: genotypy [-h] --reads READS -o OUTPUT_DIR [--loci LOCI]
                [--custom CUSTOM] [--tmpdir TMPDIR] [--threads THREADS]
                [--threshold THRESHOLD] [-v]

Detect genomic barcodes from a given set of reads in a set of defined loci
where those barcodes can be expected.

options:
  -h, --help            show this help message and exit
  --reads READS         Input reads that will be mapped on a reference locus.
                        They should correspond to a single sample.
  -o OUTPUT_DIR, --output OUTPUT_DIR
                        Output directory path
  --loci LOCI           A comma-separated list of loci to map reads on and
                        search a genomic barcode. Must be in the following
                        list of pre-defined loci: KAN.
  --custom CUSTOM       A custom config file to use genotypy on locus that are
                        not pre-defined. Can be a single path, or a comma-
                        separated list of file paths if there are multiple
                        files.
  --tmpdir TMPDIR       Temporary directory to store intermediate files like
                        indexes or bam files.
  --threads THREADS     Maximum number of threads to use.
  --threshold THRESHOLD
                        Minimum reads threshold under which no predictions
                        will be made.
  -v, --version         show program's version number and exit
```

