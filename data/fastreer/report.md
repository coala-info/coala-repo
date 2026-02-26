# fastreer CWL Generation Report

## fastreer_fastreeR

### Tool Description
fastreeR CLI: Calculate distance matrices and phylogenetic trees from VCF or FASTA files

### Metadata
- **Docker Image**: quay.io/biocontainers/fastreer:2.1.3--pyhdfd78af_0
- **Homepage**: https://github.com/gkanogiannis/fastreeR
- **Package**: https://anaconda.org/channels/bioconda/packages/fastreer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fastreer/overview
- **Total Downloads**: 870
- **Last updated**: 2026-02-06
- **GitHub**: https://github.com/gkanogiannis/fastreeR
- **Stars**: N/A
### Original Help Text
```text
usage: fastreeR.py [-h] [--lib LIB] [--mem MEM] [--pipe-stderr] [--version]
                   [--check] [--extraVerbose]
                   {VCF2DIST,VCF2TREE,DIST2TREE,FASTA2DIST,VCF2EMB} ...

fastreeR CLI: Calculate distance matrices and phylogenetic trees from VCF or
FASTA files Citation: Anestis Gkanogiannis (2016) .A scalable assembly-free
variable selection algorithm for biomarker discovery from metagenomes. BMC
Bioinformatics 17, 311 (2016) https://doi.org/10.1186/s12859-016-1186-3
https://github.com/gkanogiannis/fastreeR

positional arguments:
  {VCF2DIST,VCF2TREE,DIST2TREE,FASTA2DIST,VCF2EMB}
    VCF2DIST            Compute distance matrix from VCF(s)
    VCF2TREE            Compute tree from VCF(s)
    DIST2TREE           Compute tree from distance matrix
    FASTA2DIST          Compute distance matrix from FASTA(s)
    VCF2EMB             Generate variant embeddings from VCF using BioFM
                        genomic language model

options:
  -h, --help            show this help message and exit
  --lib LIB             Path to JAR library folder (default:
                        /usr/local/share/fastreer-2.1.3-0)
  --mem MEM             Max RAM for JVM in MB (default: 256)
  --pipe-stderr         Pipe Java stderr to CLI (default: direct passthrough
                        to terminal)
  --version             Print version information and exit
  --check               Test Java and backend availability
  --extraVerbose        Print extra messages on stderr (default: false)
```

