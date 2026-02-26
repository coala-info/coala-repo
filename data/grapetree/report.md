# grapetree CWL Generation Report

## grapetree

### Tool Description
GrapeTree generates a NEWICK tree to the default output (screen) or a redirect output, e.g., a file.

### Metadata
- **Docker Image**: quay.io/biocontainers/grapetree:2.1--pyh3252c3a_0
- **Homepage**: https://github.com/achtman-lab/GrapeTree
- **Package**: https://anaconda.org/channels/bioconda/packages/grapetree/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/grapetree/overview
- **Total Downloads**: 4.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/achtman-lab/GrapeTree
- **Stars**: N/A
### Original Help Text
```text
usage: grapetree [-h] --profile FNAME [--method TREE] [--matrix MATRIX_TYPE]
                 [--recraft] [--missing HANDLER] [--wgMLST]
                 [--heuristic HEURISTIC] [--n_proc NUMBER_OF_PROCESSES]
                 [--check] [--block_penalty BLOCK_PENALTY]

For details, see "https://github.com/achtman-lab/GrapeTree/blob/master/README.md".
In brief, GrapeTree generates a NEWICK tree to the default output (screen) 
or a redirect output, e.g., a file. 

optional arguments:
  -h, --help            show this help message and exit
  --profile FNAME, -p FNAME
                        [REQUIRED] An input filename of a file containing MLST or SNP character data, OR a fasta file containing aligned sequences. 
  --method TREE, -m TREE
                        "MSTreeV2" [DEFAULT]
                        "MSTree"
                        "NJ": FastME V2 NJ tree
                        "RapidNJ": RapidNJ for very large datasets
                        "ninja": Alternative NJ algorithm for very large datasets
                        "distance": allelic distance matrix in PHYLIP format.
  --matrix MATRIX_TYPE, -x MATRIX_TYPE
                        "symmetric": [DEFAULT: MSTree, NJ and RapidNJ] 
                        "asymmetric": [DEFAULT: MSTreeV2].
                        "blockwise": (experimental for ordered loci) A different locus is given less penalty (defined by -b) if the previous locus is also different
  --recraft, -r         Triggers local branch recrafting. [DEFAULT: MSTreeV2]. 
  --missing HANDLER, -y HANDLER
                        ONLY FOR symmetric DISTANCE MATRIX. 
                        0: [DEFAULT] ignore missing data in pairwise comparison. 
                        1: Remove column with missing data. 
                        2: treat data as an allele. 
                        3: Absolute number of allelic differences. 
  --wgMLST, -w          [EXPERIMENTAL] a better support of wgMLST schemes.
  --heuristic HEURISTIC, -t HEURISTIC
                        Tiebreak heuristic used only in MSTree and MSTreeV2
                        "eBurst" [DEFAULT: MSTree]
                        "harmonic" [DEFAULT: MSTreeV2]
  --n_proc NUMBER_OF_PROCESSES, -n NUMBER_OF_PROCESSES
                        Number of CPU processes in parallel use. [DEFAULT]: 5. 
  --check, -c           Only calculate the expected time/memory requirements. 
  --block_penalty BLOCK_PENALTY, -b BLOCK_PENALTY
                        [DEFAULT: 0.01] The penalty that is given to a different locus if it is led by another difference. Only works for "-x blockwise"
```

