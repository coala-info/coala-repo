# bcbio-rnaseq CWL Generation Report

## bcbio-rnaseq_compare

### Tool Description
Compare RNA-seq experiments

### Metadata
- **Docker Image**: quay.io/biocontainers/bcbio-rnaseq:1.2.0--r3.3.2_3
- **Homepage**: https://github.com/hbc/bcbioRNASeq
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bcbio-rnaseq/overview
- **Total Downloads**: 39.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/hbc/bcbioRNASeq
- **Stars**: N/A
### Original Help Text
```text
Usage: bcbio-rnaseq compare [options] project-file key

Options:
  -h, --help
  -n, --cores CORES  1  Number of cores
      --counts-only     Only run count-based analyses
      --seqc            Data is from a SEQC alignment

Arguments:
  project-file    A bcbio-nextgen project file
  key             Key in the metadata field to do pairwise comparisons
```


## bcbio-rnaseq_simulate

### Tool Description
Simulate RNA-Seq data

### Metadata
- **Docker Image**: quay.io/biocontainers/bcbio-rnaseq:1.2.0--r3.3.2_3
- **Homepage**: https://github.com/hbc/bcbioRNASeq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: bcbio-rnaseq simulate [options]

Options:
  -h, --help
  -d, --out-dir OUT_DIR          simulate  Output directory
  -c, --count-file COUNT_FILE              Optional count file for abudance distribution
  -s, --sample-size SAMPLE_SIZE  3         Sample size of each group
  -n, --num-genes NUM_GENES      10000     Number of genes to simulate.
  -l, --library-size SIZE        20        Library size in millions of reads
```


## bcbio-rnaseq_summarize

### Tool Description
Summarize RNA-Seq analysis results from a bcbio project.

### Metadata
- **Docker Image**: quay.io/biocontainers/bcbio-rnaseq:1.2.0--r3.3.2_3
- **Homepage**: https://github.com/hbc/bcbioRNASeq
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: bcbio-rnaseq summarize bcbio-project-file.yaml

Options:
  -h, --help
  -f, --formula FORMULA      Formula to use in model (example: ~ batch + condition)
  -d, --dexseq               Run DEXSeq
  -o, --organism ORGANISM    organism (mouse, human)
  -s, --sleuth               Run Sleuth
```


## Metadata
- **Skill**: generated
