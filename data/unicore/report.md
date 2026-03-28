# unicore CWL Generation Report

## unicore_easy-core

### Tool Description
Easy core gene phylogeny workflow, from fasta files to phylogenetic tree

### Metadata
- **Docker Image**: quay.io/biocontainers/unicore:1.1.1--h7ef3eeb_0
- **Homepage**: https://github.com/steineggerlab/unicore
- **Package**: https://anaconda.org/channels/bioconda/packages/unicore/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/unicore/overview
- **Total Downloads**: 2.2K
- **Last updated**: 2025-05-20
- **GitHub**: https://github.com/steineggerlab/unicore
- **Stars**: N/A
### Original Help Text
```text
Easy core gene phylogeny workflow, from fasta files to phylogenetic tree

Usage: unicore easy-core [OPTIONS] <INPUT> <OUTPUT> <MODEL> <TMP>

Arguments:
  <INPUT>   Input directory with fasta files or a single fasta file
  <OUTPUT>  Output directory where all results will be saved
  <MODEL>   ProstT5 model
  <TMP>     tmp directory

Options:
  -k, --keep
          Keep intermediate files
  -w, --overwrite
          Force overwrite output database
      --max-len <MAX_LEN>
          Set maximum sequence length threshold
  -g, --gpu
          Use GPU for foldseek createdb
      --afdb-lookup <AFDB_LOOKUP>
          Use AFDB lookup for foldseek createdb. Useful for large databases
      --custom-lookup <CUSTOM_LOOKUP>
          Use custom lookup database, accepts any Foldseek database to reference against
  -c, --cluster-options <CLUSTER_OPTIONS>
          Arguments for foldseek options in string e.g. -c "-c 0.8" [default: "-c 0.8"]
  -C, --core-threshold <CORE_THRESHOLD>
          Coverage threshold for core structures. [0 - 100] [default: 80]
  -p, --print-copiness
          Generate tsv with copy number statistics
  -A, --aligner <ALIGNER>
          Multiple sequence aligner [foldmason, mafft-linsi, mafft] [default: foldmason]
  -n, --no-inference
          Stop the tree module after alignment (before tree inference)
  -T, --tree-builder <TREE_BUILDER>
          Phylogenetic tree builder [iqtree, fasttree, raxml-ng] [default: iqtree]
  -a, --aligner-options <ALIGNER_OPTIONS>
          Options for sequence aligner
  -p, --tree-options <TREE_OPTIONS>
          Options for tree builder; If not given, following options will be applied:
          iqtree:   -m JTT+F+I+G -B 1000
          fasttree: -gamma -boot 1000
          raxml-ng: --model JTT+F+I+G --seed 12345 --all --tree pars{90},rand{10}
  -G, --gap-threshold <GAP_THRESHOLD>
          Gap threshold for multiple sequence alignment [0 - 100] [default: 50]
      --threads <THREADS>
          Number of threads to use; 0 to use all [default: 0]
  -v, --verbosity <VERBOSITY>
          Verbosity (0: quiet, 1: +errors, 2: +warnings, 3: +info, 4: +debug) [default: 3]
  -h, --help
          Print help
```


## unicore_createdb

### Tool Description
Create Foldseek database from amino acid sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/unicore:1.1.1--h7ef3eeb_0
- **Homepage**: https://github.com/steineggerlab/unicore
- **Package**: https://anaconda.org/channels/bioconda/packages/unicore/overview
- **Validation**: PASS

### Original Help Text
```text
Create Foldseek database from amino acid sequences

Usage: unicore createdb [OPTIONS] <INPUT> <OUTPUT> <MODEL>

Arguments:
  <INPUT>   Input directory with fasta files or a single fasta file
  <OUTPUT>  Output foldseek database
  <MODEL>   ProstT5 model

Options:
  -k, --keep                           Keep intermediate files
  -o, --overwrite                      Force overwrite output database
      --max-len <MAX_LEN>              Set maximum sequence length threshold
  -g, --gpu                            Use GPU for foldseek createdb
      --afdb-lookup <AFDB_LOOKUP>      Use AFDB lookup for foldseek createdb. Useful for large databases
      --custom-lookup <CUSTOM_LOOKUP>  Use custom lookup database, accepts any Foldseek database to reference against
      --threads <THREADS>              Number of threads to use; 0 to use all [default: 0]
  -v, --verbosity <VERBOSITY>          Verbosity (0: quiet, 1: +errors, 2: +warnings, 3: +info, 4: +debug) [default: 3]
  -h, --help                           Print help
```


## unicore_cluster

### Tool Description
Cluster Foldseek database

### Metadata
- **Docker Image**: quay.io/biocontainers/unicore:1.1.1--h7ef3eeb_0
- **Homepage**: https://github.com/steineggerlab/unicore
- **Package**: https://anaconda.org/channels/bioconda/packages/unicore/overview
- **Validation**: PASS

### Original Help Text
```text
Cluster Foldseek database

Usage: unicore cluster [OPTIONS] <INPUT> <OUTPUT> <TMP>

Arguments:
  <INPUT>   Input database (createdb output)
  <OUTPUT>  Output prefix; the result will be saved as OUTPUT.tsv
  <TMP>     Temp directory

Options:
  -k, --keep-cluster-db
          Keep intermediate Foldseek cluster database
  -c, --cluster-options <CLUSTER_OPTIONS>
          Arguments for foldseek options in string e.g. -c "-c 0.8" [default: "-c 0.8"]
      --threads <THREADS>
          Number of threads to use; 0 to use all [default: 0]
  -v, --verbosity <VERBOSITY>
          Verbosity (0: quiet, 1: +errors, 2: +warnings, 3: +info, 4: +debug) [default: 3]
  -h, --help
          Print help
```


## unicore_search

### Tool Description
Search Foldseek database against reference database

### Metadata
- **Docker Image**: quay.io/biocontainers/unicore:1.1.1--h7ef3eeb_0
- **Homepage**: https://github.com/steineggerlab/unicore
- **Package**: https://anaconda.org/channels/bioconda/packages/unicore/overview
- **Validation**: PASS

### Original Help Text
```text
Search Foldseek database against reference database

Usage: unicore search [OPTIONS] <INPUT> <TARGET> <OUTPUT> <TMP>

Arguments:
  <INPUT>   Input database
  <TARGET>  Target database to search against
  <OUTPUT>  Output prefix; the result will be saved as OUTPUT.m8
  <TMP>     Temp directory

Options:
  -k, --keep-aln-db
          Keep intermediate Foldseek alignment database
  -s, --search-options <SEARCH_OPTIONS>
          Arguments for foldseek options in string e.g. -s "-c 0.8" [default: "-c 0.8"]
      --threads <THREADS>
          Number of threads to use; 0 to use all [default: 0]
  -v, --verbosity <VERBOSITY>
          Verbosity (0: quiet, 1: +errors, 2: +warnings, 3: +info, 4: +debug) [default: 3]
  -h, --help
          Print help
```


## unicore_profile

### Tool Description
Create core structures from Foldseek database

### Metadata
- **Docker Image**: quay.io/biocontainers/unicore:1.1.1--h7ef3eeb_0
- **Homepage**: https://github.com/steineggerlab/unicore
- **Package**: https://anaconda.org/channels/bioconda/packages/unicore/overview
- **Validation**: PASS

### Original Help Text
```text
Create core structures from Foldseek database

Usage: unicore profile [OPTIONS] <INPUT_DB> <INPUT_TSV> <OUTPUT>

Arguments:
  <INPUT_DB>   Input database (createdb output)
  <INPUT_TSV>  Input tsv file (cluster or search output)
  <OUTPUT>     Output directory

Options:
  -t, --threshold <THRESHOLD>  Coverage threshold for core structures. [0 - 100] [default: 80]
  -p, --print-copiness         Generate tsv with copy number statistics
      --threads <THREADS>      Number of threads to use; 0 to use all [default: 0]
  -v, --verbosity <VERBOSITY>  Verbosity (0: quiet, 1: +errors, 2: +warnings, 3: +info, 4: +debug) [default: 3]
  -h, --help                   Print help

Example:
  # Define core genes above 85% coverage threshold
  unicore profile -t 85 example/db/proteome_db example/out/clu.tsv result
```


## unicore_tree

### Tool Description
Infer phylogenetic tree from core structures

### Metadata
- **Docker Image**: quay.io/biocontainers/unicore:1.1.1--h7ef3eeb_0
- **Homepage**: https://github.com/steineggerlab/unicore
- **Package**: https://anaconda.org/channels/bioconda/packages/unicore/overview
- **Validation**: PASS

### Original Help Text
```text
Infer phylogenetic tree from core structures

Usage: unicore tree [OPTIONS] <DB> <INPUT> <OUTPUT>

Arguments:
  <DB>      Input database (createdb output)
  <INPUT>   Input directory containing core structures (profile output)
  <OUTPUT>  Output directory

Options:
  -a, --aligner <ALIGNER>
          Multiple sequence aligner [foldmason, mafft-linsi, mafft] [default: foldmason]
  -t, --tree-builder <TREE_BUILDER>
          Phylogenetic tree builder [iqtree, fasttree, raxml-ng] [default: iqtree]
  -o, --aligner-options <ALIGNER_OPTIONS>
          Options for sequence aligner
  -n, --no-inference
          Stop the tree module after alignment (before tree inference)
  -p, --tree-options <TREE_OPTIONS>
          Options for tree builder; If not given, following options will be applied:
          iqtree:   -m JTT+F+I+G -B 1000
          fasttree: -gamma -boot 1000
          raxml-ng: --model JTT+F+I+G --seed 12345 --all --tree pars{90},rand{10}
  -d, --threshold <THRESHOLD>
          Gap threshold for multiple sequence alignment [0 - 100] [default: 50]
  -c, --threads <THREADS>
          Number of threads to use; 0 to use all [default: 0]
  -v, --verbosity <VERBOSITY>
          Verbosity (0: quiet, 1: +errors, 2: +warnings, 3: +info, 4: +debug) [default: 3]
  -h, --help
          Print help
```


## unicore_gene-tree

### Tool Description
Infer phylogenetic tree of each core structures

### Metadata
- **Docker Image**: quay.io/biocontainers/unicore:1.1.1--h7ef3eeb_0
- **Homepage**: https://github.com/steineggerlab/unicore
- **Package**: https://anaconda.org/channels/bioconda/packages/unicore/overview
- **Validation**: PASS

### Original Help Text
```text
Infer phylogenetic tree of each core structures

Usage: unicore gene-tree [OPTIONS] <INPUT>

Arguments:
  <INPUT>  Input directory containing species phylogenetic tree (Output of the Tree module)

Options:
  -n, --names <NAMES>
          File containing core structures for computing phylogenetic tree. If not provided, all core structures will be used [default: ]
  -T, --tree-builder <TREE_BUILDER>
          Phylogenetic tree builder [iqtree, fasttree, raxml-ng] [default: iqtree]
  -p, --tree-options <TREE_OPTIONS>
          Options for tree builder; If not given, following options will be applied:
          iqtree:   -m JTT+F+I+G -B 1000
          fasttree: -gamma -boot 1000
          raxml-ng: --model JTT+F+I+G --seed 12345 --all --tree pars{90},rand{10}
  -f, --realign
          Compute the Multiple sequence alignment again. This will overwrite the previous alignment
  -a, --aligner <ALIGNER>
          Multiple sequence aligner [foldmason, mafft-linsi, mafft] [default: foldmason]
  -o, --aligner-options <ALIGNER_OPTIONS>
          Options for sequence aligner
  -d, --threshold <THRESHOLD>
          Gap threshold for multiple sequence alignment [0 - 100] [default: 50]
  -c, --threads <THREADS>
          Number of threads to use; 0 to use all [default: 0]
  -v, --verbosity <VERBOSITY>
          Verbosity (0: quiet, 1: +errors, 2: +warnings, 3: +info, 4: +debug) [default: 3]
  -h, --help
          Print help

Example:
  # Create a list of hashed gene names
  awk -F'\t' 'NR==FNR {a[$1];next} ($3 in a) {print $1}' /path/to/original/gene/names db/proteome_db.map > /path/to/hashed/gene/names
  # Run gene-tree with the list of hashed gene names; use --realign option to recompute the alignment with custom --threshold option for MSA gap threshold
  unicore gene-tree --realign --threshold 30 --name /path/to/hashed/gene/names example/tree
```


## unicore_config

### Tool Description
Runtime environment configuration

### Metadata
- **Docker Image**: quay.io/biocontainers/unicore:1.1.1--h7ef3eeb_0
- **Homepage**: https://github.com/steineggerlab/unicore
- **Package**: https://anaconda.org/channels/bioconda/packages/unicore/overview
- **Validation**: PASS

### Original Help Text
```text
Runtime environment configuration

Usage: unicore config [OPTIONS]

Options:
  -c, --check
          Check current environment configuration
      --set-mmseqs <SET_MMSEQS>
          Set mmseqs binary path
      --set-foldseek <SET_FOLDSEEK>
          Set foldseek binary path
      --set-foldmason <SET_FOLDMASON>
          Set foldmason binary path
      --set-mafft <SET_MAFFT>
          Set mafft binary path
      --set-mafft-linsi <SET_MAFFT_LINSI>
          Set mafft-linsi binary path
      --set-iqtree <SET_IQTREE>
          Set iqtree binary path
      --set-fasttree <SET_FASTTREE>
          Set fasttree binary path
      --set-raxml <SET_RAXML>
          Set raxml-ng binary path
  -v, --verbosity <VERBOSITY>
          Verbosity (0: quiet, 1: +errors, 2: +warnings, 3: +info, 4: +debug) [default: 3]
  -h, --help
          Print help
```


## Metadata
- **Skill**: generated
