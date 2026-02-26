# haslr CWL Generation Report

## haslr_haslr.py

### Tool Description
A tool for long-read-first assembly.

### Metadata
- **Docker Image**: quay.io/biocontainers/haslr:0.8a1--py310h275bdba_6
- **Homepage**: https://github.com/vpc-ccg/haslr
- **Package**: https://anaconda.org/channels/bioconda/packages/haslr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/haslr/overview
- **Total Downloads**: 10.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/vpc-ccg/haslr
- **Stars**: N/A
### Original Help Text
```text
usage: haslr.py [-t THREADS] -o OUT_DIR -g GENOME_SIZE -l LONG -x LONG_TYPE -s SHORT [SHORT ...]

required arguments:
  -o, --out OUT_DIR              output directory
  -g, --genome GENOME_SIZE       estimated genome size; accepted suffixes are k,m,g
  -l, --long LONG                long read file
  -x, --type LONG_TYPE           type of long reads chosen from {pacbio,nanopore}
  -s, --short SHORT [SHORT ...]  short read file

optional arguments:
  -t, --threads THREADS          number of CPU threads to use [1]
  --cov-lr COV_LR                amount of long read coverage to use for assembly [25]
  --aln-block ALN_BLOCK          minimum length of alignment block [500]
  --aln-sim ALN_SIM              minimum alignment similarity [0.85]
  --edge-sup EDGE_SUP            minimum number of long read supporting each edge [3]
  --minia-kmer MINIA_KMER        kmer size used by minia [49]
  --minia-solid MINIA_SOLID      minimum kmer abundance used by minia [3]
  --minia-asm MINIA_ASM          type of minia assembly chosen from {contigs,unitigs} [contigs]
  -v, --version                  print version
  -h, --help                     show this help message and exit
```

