# omamer CWL Generation Report

## omamer_mkdb

### Tool Description
Build a database, by providing an OMA HDF5 database file [BROWSERBUILD] or
OrthoXML + FASTA + Newick files [OXMLBUILD].

### Metadata
- **Docker Image**: quay.io/biocontainers/omamer:2.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/DessimozLab/omamer
- **Package**: https://anaconda.org/channels/bioconda/packages/omamer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/omamer/overview
- **Total Downloads**: 6.8K
- **Last updated**: 2025-10-19
- **GitHub**: https://github.com/DessimozLab/omamer
- **Stars**: N/A
### Original Help Text
```text
usage: omamer mkdb [-h] -d DB
                   [-t {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}]
                   [--min_fam_size MIN_FAM_SIZE]
                   [--min_fam_completeness MIN_FAM_COMPLETENESS]
                   [--logic {AND,OR}] [--root_taxon ROOT_TAXON]
                   [--hidden_taxa HIDDEN_TAXA] [--reduced_alphabet] [--k K]
                   [--oma_path OMA_PATH] [--orthoxml ORTHOXML]
                   [--species_tree SPECIES_TREE] [--sequences [SEQUENCES ...]]
                   [--log_level {debug,info,warning}]

Build a database, by providing an OMA HDF5 database file [BROWSERBUILD] or
OrthoXML + FASTA + Newick files [OXMLBUILD].

options:
  -h, --help            show this help message and exit
  -d DB, --db DB        Path to new database (including filename). (default:
                        None)
  -t {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}, --nthreads {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}
                        Number of threads to use (default: 1)
  --min_fam_size MIN_FAM_SIZE
                        Only root-HOGs with a protein count passing this
                        threshold are used. (default: 6)
  --min_fam_completeness MIN_FAM_COMPLETENESS
                        Only root-HOGs passing this threshold are used. The
                        completeness of a HOG is defined as the number of
                        observed species divided by the expected number of
                        species at the HOG taxonomic level (default: 0.5)
  --logic {AND,OR}      Logic used between the two above arguments to filter
                        root-HOGs. Options are AND or OR. (default: OR)
  --root_taxon ROOT_TAXON
                        HOGs defined at, or descending from, this taxon are
                        uses as root-HOGs. Default is the top level in species
                        tree. (default: None)
  --hidden_taxa HIDDEN_TAXA
                        Optional -- path to a file giving a list of taxa to
                        hide the proteins during index creation only. HOGs
                        will still exist in the database, but it will not be
                        possible to place to them. Names must match EXACTLY to
                        those in the given newick species tree. (default:
                        None)
  --reduced_alphabet    Use reduced alphabet from Linclust paper. (default:
                        False)
  --k K                 k-mer length (default: 6)
  --oma_path OMA_PATH   Path to OMA browser release (must include OmaServer.h5
                        and speciestree.nwk). [BROWSERBUILD] (default: None)
  --orthoxml ORTHOXML   Path to OrthoXML file containing HOGs. [OXMLBUILD]
                        (default: None)
  --species_tree SPECIES_TREE
                        Path to newick file containing species tree.
                        [OXMLBUILD] (default: None)
  --sequences [SEQUENCES ...]
                        Paths to sequence files (1 or multiple, only for non-
                        browser build). [OXMLBUILD] (default: None)
  --log_level {debug,info,warning}
                        Logging level. (default: info)
```


## omamer_search

### Tool Description
Search for protein sequences, given in FASTA format, against an existing database.

### Metadata
- **Docker Image**: quay.io/biocontainers/omamer:2.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/DessimozLab/omamer
- **Package**: https://anaconda.org/channels/bioconda/packages/omamer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: omamer search [-h] -d DB -q QUERY [--threshold THRESHOLD]
                     [--family_alpha FAMILY_ALPHA] [-fo] [-n TOP_N_FAMS]
                     [--reference_taxon REFERENCE_TAXON] [-o OUT]
                     [--include_extant_genes] [-c CHUNKSIZE]
                     [-t {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}]
                     [--log_level {debug,info,warning}] [--silent]

Search for protein sequences, given in FASTA format, against an existing
database.

options:
  -h, --help            show this help message and exit
  -d DB, --db DB        Path to existing database (including filename).
                        (default: None)
  -q QUERY, --query QUERY
                        Path to FASTA formatted sequences (default: None)
  --threshold THRESHOLD
                        Threshold applied on the OMAmer-score that is used to
                        vary the specificity of predicted HOGs. The lower the
                        theshold the more (over-)specific predicted HOGs will
                        be. (default: 0.1)
  --family_alpha FAMILY_ALPHA
                        Significance threshold used when filtering families.
                        (default: 1e-06)
  -fo, --family_only    Set to only place at family level. Note:
                        subfamily_medianseqlen in results is for the family
                        level. (default: False)
  -n TOP_N_FAMS, --top_n_fams TOP_N_FAMS
                        Number of top level families to place into. By
                        default, placed into only in the best scoring family.
                        (default: 1)
  --reference_taxon REFERENCE_TAXON
                        The placement is stopped when reaching the reference
                        taxon (must exist in the OMA database). (default:
                        None)
  -o OUT, --out OUT     Path to output. If not set, defaults to stdout
                        (default: None)
  --include_extant_genes
                        Include extant gene IDs as comma separated entry in
                        results. (default: False)
  -c CHUNKSIZE, --chunksize CHUNKSIZE
                        Number of queries to process at once. (default: 10000)
  -t {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}, --nthreads {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}
                        Number of threads to use (default: 1)
  --log_level {debug,info,warning}
                        Logging level. (default: info)
  --silent              Silence output (default: False)
```


## omamer_info

### Tool Description
Show metadata about an existing omamer database

### Metadata
- **Docker Image**: quay.io/biocontainers/omamer:2.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/DessimozLab/omamer
- **Package**: https://anaconda.org/channels/bioconda/packages/omamer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: omamer info [-h] -d DB

Show metadata about an existing omamer database

options:
  -h, --help      show this help message and exit
  -d DB, --db DB  Path to an existing database (including filename).
```

