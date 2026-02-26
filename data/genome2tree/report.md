# genome2tree CWL Generation Report

## genome2tree_genome2tree.py

### Tool Description
Pipeline to create a supermatrix from FASTA files

### Metadata
- **Docker Image**: quay.io/biocontainers/genome2tree:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/RicoLeiser/Genome2Tree
- **Package**: https://anaconda.org/channels/bioconda/packages/genome2tree/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/genome2tree/overview
- **Total Downloads**: 184
- **Last updated**: 2025-09-04
- **GitHub**: https://github.com/RicoLeiser/Genome2Tree
- **Stars**: N/A
### Original Help Text
```text
usage: genome2tree.py [-h] -i INPUT -o OUTPUT [-p PREFIX] [-t THREADS] [--dna]
                      [--force]

Pipeline to create a supermatrix from FASTA files

options:
  -h, --help            show this help message and exit
  -i, --input INPUT     Directory containing input FASTA files (.faa or .fna)
                        (default: None)
  -o, --output OUTPUT   Output directory for all results (default: None)
  -p, --prefix PREFIX   Prefix for output supermatrix files (default:
                        supermatrix)
  -t, --threads THREADS
                        Number of threads to use (default: 4)
  --dna                 Input files are DNA (.fna); will be translated with
                        Prodigal (default: False)
  --force               Force rerun of OrthoFinder even if results exist
                        (default: False)
```

