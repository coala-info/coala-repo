# motulizer CWL Generation Report

## motulizer_mOTUlize.py

### Tool Description
From a set of genomes, makes metagenomic Operational Taxonomic Units (mOTUs). By default it makes a graph of 95% (reciprocal) ANI (with fastANI) connected MAGs (with completeness > 40%, contamination < 5%). The mOTUs will be the connected components of this graph, to which smaller "SUBs" with ANI > 95% are recruited. If similarities provided, it should be a TAB-separated file with columns as query, subject and similarity (in percent, e.g. [0-100]) if you also provide fasta-files (for stats purpouses) query and names should correspond to the fasta-files you provide. If the columns are file names, the folders are removed (mainly so it can read fastANI output directly).

### Metadata
- **Docker Image**: quay.io/biocontainers/motulizer:0.3.2--pyhdfd78af_0
- **Homepage**: https://github.com/moritzbuck/mOTUlizer/
- **Package**: https://anaconda.org/channels/bioconda/packages/motulizer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/motulizer/overview
- **Total Downloads**: 17.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/moritzbuck/mOTUlizer
- **Stars**: N/A
### Original Help Text
```text
usage: mOTUlize [-h] [--output [OUTPUT]] [--force] [--checkm [CHECKM]]
                [--similarities [SIMILARITIES]] [--fnas [FNAS [FNAS ...]]]
                [--prefix [PREFIX]] [--MAG-completeness [MAG_COMPLETENESS]]
                [--MAG-contamination [MAG_CONTAMINATION]]
                [--SUB-completeness [SUB_COMPLETENESS]]
                [--SUB-contamination [SUB_CONTAMINATION]]
                [--similarity-cutoff [SIMILARITY_CUTOFF]] [--threads THREADS]
                [--keep-simi-file [KEEP_SIMI_FILE]] [--txt] [--long]
                [--version]

From a set of genomes, makes metagenomic Operational Taxonomic Units (mOTUs).
By default it makes a graph of 95% (reciprocal) ANI (with fastANI) connected
MAGs (with completeness > 40%, contamination < 5%). The mOTUs will be the
connected components of this graph, to which smaller "SUBs" with ANI > 95% are
recruited. If similarities provided, it should be a TAB-separated file with
columns as query, subject and similarity (in percent, e.g. [0-100]) if you
also provide fasta-files (for stats purpouses) query and names should
correspond to the fasta-files you provide. If the columns are file names, the
folders are removed (mainly so it can read fastANI output directly).

optional arguments:
  -h, --help            show this help message and exit
  --output [OUTPUT], -o [OUTPUT]
                        send output to this file
  --force, -f           force execution (overwritting existing files)
  --checkm [CHECKM], -k [CHECKM]
                        checkm file (or whatever you want to use as
                        completness), if not provided, all genomes are assumed
                        to be seed MAG (e.g complete enough)
  --similarities [SIMILARITIES], -I [SIMILARITIES]
                        file containing similarities between MAGs, if not
                        provided, will use fastANI to compute one
  --fnas [FNAS [FNAS ...]], -F [FNAS [FNAS ...]]
                        list of nucleotide fasta-files of MAGs or whatnot
  --prefix [PREFIX], -n [PREFIX]
                        prefix for the mOTU names, default : mOTU_
  --MAG-completeness [MAG_COMPLETENESS], --MC [MAG_COMPLETENESS], -M [MAG_COMPLETENESS]
                        completeness cutoff for seed MAGs, default : 40
  --MAG-contamination [MAG_CONTAMINATION], --Mc [MAG_CONTAMINATION], -m [MAG_CONTAMINATION]
                        contamination cutoff for seed MAGs, default : 5
  --SUB-completeness [SUB_COMPLETENESS], --SC [SUB_COMPLETENESS], -S [SUB_COMPLETENESS]
                        completeness cutoff for recruited SUBs, default : 0
  --SUB-contamination [SUB_CONTAMINATION], --Sc [SUB_CONTAMINATION], -s [SUB_CONTAMINATION]
                        contamination cutoff for recruited SUBs, default : 100
  --similarity-cutoff [SIMILARITY_CUTOFF], -i [SIMILARITY_CUTOFF]
                        distance cutoff for making the graph, default : 95
  --threads THREADS, -t THREADS
                        number of threads (default all, e.g. 20)
  --keep-simi-file [KEEP_SIMI_FILE], -K [KEEP_SIMI_FILE]
                        keep generated similarity file if '--similarities' is
                        not provided, does nothing if '--similarity' is
                        provided
  --txt, -T             the '--fnas' switch indicates a file with paths
  --long                longform output, a JSON-file with a lot more
                        information (might be cryptic...)
  --version, -v         get version

Let's do this
```


## motulizer_mOTUpan.py

### Tool Description
From a buch of amino-acid sequences or COG-sets, computes concensus AA/COG sets. Returns all to stdout by default.

### Metadata
- **Docker Image**: quay.io/biocontainers/motulizer:0.3.2--pyhdfd78af_0
- **Homepage**: https://github.com/moritzbuck/mOTUlizer/
- **Package**: https://anaconda.org/channels/bioconda/packages/motulizer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mOTUpan.py [-h] [--output OUTPUT] [--force] [--checkm CHECKM]
                  [--seed [SEED]] [--length_seed] [--random_seed]
                  [--genome2gene_clusters_only] [--precluster]
                  [--faas [FAAS [FAAS ...]]] [--txt]
                  [--gene_clusters_file [GENE_CLUSTERS_FILE]] [--name NAME]
                  [--long] [--boots BOOTS] [--max_iter MAX_ITER]
                  [--threads THREADS] [--version]

From a buch of amino-acid sequences or COG-sets, computes concensus AA/COG
sets. Returns all to stdout by default.

optional arguments:
  -h, --help            show this help message and exit
  --output OUTPUT, -o OUTPUT
                        send output to this file
  --force, -f           force execution answering default answers
  --checkm CHECKM, -k CHECKM
                        checkm file if you want to seed completnesses with it,
                        accepts concatenations of multiple checkm-files, check
                        manual for more formating options
  --seed [SEED], -s [SEED]
                        seed completeness, advice a number around 90 (95
                        default), this is the default completeness prior
  --length_seed, --ls   seed completeness by length fraction [0-100]
  --random_seed, --rs   random seed completeness between 5 and 95 percent
  --genome2gene_clusters_only
                        returns genome2gene_clusters only
  --precluster          precluster proteomes with cd-hit, mainly for legacy
                        reasons, mmseqs2 is faaaaaast
  --faas [FAAS [FAAS ...]], -F [FAAS [FAAS ...]]
                        list of amino-acids faas of MAGs or whatnot, or a text
                        file with paths to the faas (with the --txt switch)
  --txt                 the '--faas' switch indicates a file with paths
  --gene_clusters_file [GENE_CLUSTERS_FILE], --gene_clusterss [GENE_CLUSTERS_FILE], -c [GENE_CLUSTERS_FILE]
                        file with COG-sets (see doc)
  --name NAME, -n NAME  if you want to name this bag of bins
  --long                longform output, a JSON-file with a lot more
                        information (might be cryptic...)
  --boots BOOTS, -b BOOTS
                        number of bootstraps for fpr and recall estimate
                        (default 0), careful, slows down program linearly
  --max_iter MAX_ITER, -m MAX_ITER
                        max number of iterations (set to one if you have only
                        few traits, e.g. re-estimation of completeness is
                        nonsensical)
  --threads THREADS, -t THREADS
                        number of threads (default all, e.g. 20), only gene
                        clustering is multithreaded right now, the rest is to
                        come
  --version, -v         get version

Let's do this
/usr/local/bin/mOTUpan.py Version 0.3.2
```


## motulizer_mOTUconvert.py

### Tool Description
Converts output of diverse software generatig COGs, or genetically encoded traits into a genome2gene_clusters-JSON file useable by mOTUpan

### Metadata
- **Docker Image**: quay.io/biocontainers/motulizer:0.3.2--pyhdfd78af_0
- **Homepage**: https://github.com/moritzbuck/mOTUlizer/
- **Package**: https://anaconda.org/channels/bioconda/packages/motulizer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mOTUconverts.py [-h] [--output [OUTPUT]] [--gene2genome [GENE2GENOME]]
                       [--in_type [IN_TYPE]] [--version] [--list] [--count]
                       [INPUT]

Converts output of diverse software generatig COGs, or genetically encoded
traits into a genome2gene_clusters-JSON file useable by mOTUpan

positional arguments:
  INPUT                 input file(s), check '--list' for specifics

optional arguments:
  -h, --help            show this help message and exit
  --output [OUTPUT], -o [OUTPUT]
                        send output to this file defaults to stdout
  --gene2genome [GENE2GENOME]
                        if gene names not '${genome_name}_[0-9]*', a tab
                        separated file with id of gene in the fist column and
                        a semi-column separated second column containing
                        genomes_id of genomes containing it
  --in_type [IN_TYPE], -I [IN_TYPE]
                        software generating the input
  --version, -v         get version and exit
  --list, -l            list tools available and exit
  --count, -c           count the occurences of COG/trait

Let's do this
```


## Metadata
- **Skill**: generated
