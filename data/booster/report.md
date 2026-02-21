# booster CWL Generation Report

## booster

### Tool Description
Renewing Felsenstein's Phylogenetic Bootstrap in the Era of Big Data. Computes normalized or raw support values for phylogenetic trees.

### Metadata
- **Docker Image**: quay.io/biocontainers/booster:0.1.2--hec16e2b_4
- **Homepage**: https://github.com/evolbioinfo/booster
- **Package**: https://anaconda.org/channels/bioconda/packages/booster/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/booster/overview
- **Total Downloads**: 6.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/evolbioinfo/booster
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
An option is missing
Usage: /usr/local/bin/booster -i <ref tree file (newick)> -b <bootstrap tree file (newick)> [-@ <cpus> -d <dist_cutoff> -r <raw distance output tree file> -S <stat file> -o <output tree> -v]
Options:
      -i, --input            : Input tree file
      -b, --boot             : Bootstrap tree file (1 file containing all bootstrap trees)
      -o, --out              : Output file (optional) with normalized support values, default : stdout
      -r, --out-raw          : Output file (optional) with raw support values in the form of id|avgdist|depth, default : none
      -@, --num-threads      : Number of threads (default 1)
      -S, --stat-file        : Prints output statistics for each branch in the given output file (optional)
      -c, --count-per-branch : Prints individual taxa moves for each branches in the log file (only with -S & -a tbe)
      -d, --dist-cutoff      : Distance cutoff to consider a branch for taxa transfer index computation (-a tbe only, default 0.3)
      -a, --algo             : tbe or fbp (default tbe)
      -q, --quiet            : Does not print progress messages during analysis
      -v, --version          : Prints version (optional)
      -h, --help             : Prints this help

If you use BOOSTER, please cite:
Renewing Felsenstein's Phylogenetic Bootstrap in the Era of Big Data
F. Lemoine, J.-B. Domelevo-Entfellner, E. Wilkinson, D. Correia, M. Davila Felipe, T. De Oliveira, O. Gascuel.
Nature 556, 452-456 (2018)

== Err. in file 'booster.c' (line 213), function 'main'
```


## Metadata
- **Skill**: generated
