# cladeomatic CWL Generation Report

## cladeomatic_create

### Tool Description
Create a clade from a phylogenetic tree and a set of sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/cladeomatic:0.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/phac-nml/cladeomatic
- **Package**: https://anaconda.org/channels/bioconda/packages/cladeomatic/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cladeomatic/overview
- **Total Downloads**: 1.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/phac-nml/cladeomatic
- **Stars**: N/A
### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/cladeomatic", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.9/site-packages/cladeomatic/main.py", line 45, in main
    exec('import cladeomatic.' + task)
  File "<string>", line 1, in <module>
  File "/usr/local/lib/python3.9/site-packages/cladeomatic/create.py", line 17, in <module>
    from cladeomatic.utils.phylo_tree import parse_tree
  File "/usr/local/lib/python3.9/site-packages/cladeomatic/utils/phylo_tree.py", line 4, in <module>
    from ete3 import Tree, NodeStyle, TreeStyle, TextFace, RectFace
ImportError: cannot import name 'NodeStyle' from 'ete3' (/usr/local/lib/python3.9/site-packages/ete3/__init__.py)
```


## cladeomatic_genotype

### Tool Description
Clade-O-Matic: Genotyping scheme development v. 0.1.1

### Metadata
- **Docker Image**: quay.io/biocontainers/cladeomatic:0.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/phac-nml/cladeomatic
- **Package**: https://anaconda.org/channels/bioconda/packages/cladeomatic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cladeomatic [-h] --in_var IN_VAR --in_scheme IN_SCHEME --sample_meta
                   SAMPLE_META [--genotype_meta GENOTYPE_META] --outfile
                   OUTFILE [--max_missing_positions MAX_MISSING_POSITIONS]
                   [--num_threads NUM_THREADS] [-V]

Clade-O-Matic: Genotyping scheme development v. 0.1.1

optional arguments:
  -h, --help            show this help message and exit
  --in_var IN_VAR       Either Variant Call SNP data (.vcf) or TSV SNP data
                        (.txt) (default: None)
  --in_scheme IN_SCHEME
                        Tab delimited scheme file produced by clade-o-matic
                        (default: None)
  --sample_meta SAMPLE_META
                        Tab delimited sample metadata (default: None)
  --genotype_meta GENOTYPE_META
                        Tab delimited genotype metadata (default: None)
  --outfile OUTFILE     Output Directory to put results (default: None)
  --max_missing_positions MAX_MISSING_POSITIONS
                        Maximum number of missing positions for the genotype
                        (default: 1)
  --num_threads NUM_THREADS
                        Number of threads to use (default: 1)
  -V, --version         show program's version number and exit
```


## cladeomatic_benchmark

### Tool Description
Clade-O-Matic: Benchmarking Genotyping scheme development v. 0.1.1

### Metadata
- **Docker Image**: quay.io/biocontainers/cladeomatic:0.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/phac-nml/cladeomatic
- **Package**: https://anaconda.org/channels/bioconda/packages/cladeomatic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cladeomatic [-h] --in_genotype IN_GENOTYPE --in_var IN_VAR --in_scheme
                   IN_SCHEME --submitted_genotype_col SUBMITTED_GENOTYPE_COL
                   --predicted_genotype_col PREDICTED_GENOTYPE_COL --outdir
                   OUTDIR [--prefix PREFIX] [--debug] [-V]

Clade-O-Matic: Benchmarking Genotyping scheme development v. 0.1.1

optional arguments:
  -h, --help            show this help message and exit
  --in_genotype IN_GENOTYPE
                        Genotype report made by genotyper (default: None)
  --in_var IN_VAR       Either Variant Call SNP data (.vcf) or TSV SNP data
                        (.txt) (default: None)
  --in_scheme IN_SCHEME
                        Tab delimited scheme file produced by clade-o-matic
                        (default: None)
  --submitted_genotype_col SUBMITTED_GENOTYPE_COL
                        Name of column containing submitted genotype (default:
                        None)
  --predicted_genotype_col PREDICTED_GENOTYPE_COL
                        Name of column containing predicted genotype (default:
                        None)
  --outdir OUTDIR       Output Directory to put results (default: None)
  --prefix PREFIX       Output Directory to put results (default: cladeomatic)
  --debug               Show debug information (default: False)
  -V, --version         show program's version number and exit
```


## cladeomatic_namer

### Tool Description
Clade-O-Matic: Genotyping scheme genotype namer v. 0.1.1

### Metadata
- **Docker Image**: quay.io/biocontainers/cladeomatic:0.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/phac-nml/cladeomatic
- **Package**: https://anaconda.org/channels/bioconda/packages/cladeomatic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cladeomatic [-h] --in_scheme IN_SCHEME --in_names IN_NAMES --outfile
                   OUTFILE [-V]

Clade-O-Matic: Genotyping scheme genotype namer v. 0.1.1

optional arguments:
  -h, --help            show this help message and exit
  --in_scheme IN_SCHEME
                        Cladeomatic scheme file (default: None)
  --in_names IN_NAMES   Tab delimited file of (node, name) (default: None)
  --outfile OUTFILE     Output file for updated scheme (default: None)
  -V, --version         show program's version number and exit
```

