# pyani-plus CWL Generation Report

## pyani-plus_resume

### Tool Description
Resume any (partial) run already logged in the database.

If the run was already complete, this should have no effect.
Any missing pairwise comparisons will be computed, and the the old run will be
marked as complete.
If the version of the underlying tool has changed, this will abort as the
original run cannot be completed.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyani-plus:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/pyani-plus/pyani-plus
- **Package**: https://anaconda.org/channels/bioconda/packages/pyani-plus/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pyani-plus/overview
- **Total Downloads**: 716
- **Last updated**: 2025-08-26
- **GitHub**: https://github.com/pyani-plus/pyani-plus
- **Stars**: N/A
### Original Help Text
```text
Usage: pyani-plus resume [OPTIONS]                                             
                                                                                
 Resume any (partial) run already logged in the database.                       
                                                                                
 If the run was already complete, this should have no effect.                   
 Any missing pairwise comparisons will be computed, and the the old run will be 
 marked as complete.                                                            
 If the version of the underlying tool has changed, this will abort as the      
 original run cannot be completed.                                              
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --database  -d      FILE           Path to pyANI-plus SQLite3 database.   │
│                                       [required]                             │
│    --run-id    -r      INTEGER        Which run from the database (defaults  │
│                                       to latest).                            │
│    --executor          [local|slurm]  How should the internal tools be run?  │
│                                       [default: local]                       │
│    --cache             DIRECTORY      Cache location if required for a       │
│                                       method (must be visible to cluster     │
│                                       workers).                              │
│                                       [default: .]                           │
│    --help      -h                     Show this message and exit.            │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Debugging ──────────────────────────────────────────────────────────────────╮
│ --temp         DIRECTORY  Directory to use for intermediate files, which for │
│                           debugging purposes will not be deleted. For        │
│                           clusters this must be on a shared drive. Default   │
│                           behaviour is to use a system specified temporary   │
│                           directory (specific to the compute-node when using │
│                           a cluster) and remove this afterwards.             │
│ --wtemp        DIRECTORY  Directory to use for temporary workflow            │
│                           coordination files, which for debugging purposes   │
│                           will not be deleted. For clusters this must be on  │
│                           a shared drive. Default behaviour is to use a      │
│                           system specified temporary directory (for the      │
│                           local executor) or a temporary directory under the │
│                           present direct (for clusters), and remove this     │
│                           afterwards.                                        │
│ --log          FILE       Where to record log(s). Use '-' for no logging.    │
│                           Default is no logging for the local executor, but  │
│                           otherwise "pyani-plus.log".                        │
│ --debug                   Show debugging level logging at the terminal (in   │
│                           addition to the log file).                         │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## pyani-plus_list-runs

### Tool Description
List the runs defined in a given pyANI-plus SQLite3 database.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyani-plus:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/pyani-plus/pyani-plus
- **Package**: https://anaconda.org/channels/bioconda/packages/pyani-plus/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pyani-plus list-runs [OPTIONS]                                          
                                                                                
 List the runs defined in a given pyANI-plus SQLite3 database.                  
                                                                                
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --database  -d      FILE  Path to pyANI-plus SQLite3 database. [required] │
│    --help      -h            Show this message and exit.                     │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Debugging ──────────────────────────────────────────────────────────────────╮
│ --log          FILE  Where to record log(s). Use '-' for no logging.         │
│                      [default: -]                                            │
│ --debug              Show debugging level logging at the terminal (in        │
│                      addition to the log file).                              │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## pyani-plus_delete-run

### Tool Description
Delete any single run from the given pyANI-plus SQLite3 database.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyani-plus:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/pyani-plus/pyani-plus
- **Package**: https://anaconda.org/channels/bioconda/packages/pyani-plus/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pyani-plus delete-run [OPTIONS]                                         
                                                                                
 Delete any single run from the given pyANI-plus SQLite3 database.              
                                                                                
 This will prompt the user for confirmation if the run has comparisons, or if   
 the run status is "Running", but that can be overridden.                       
 Currently this will *not* delete any linked comparisons, even if they are not  
 currently linked to another run. They will be reused should you start a new    
 run using an overlapping set of input FASTA files.                             
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --database  -d      FILE     Path to pyANI-plus SQLite3 database.         │
│                                 [required]                                   │
│    --run-id    -r      INTEGER  Which run from the database (defaults to     │
│                                 latest).                                     │
│    --force     -f               Delete without confirmation                  │
│    --help      -h               Show this message and exit.                  │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Debugging ──────────────────────────────────────────────────────────────────╮
│ --log          FILE  Where to record log(s). Use '-' for no logging.         │
│                      [default: -]                                            │
│ --debug              Show debugging level logging at the terminal (in        │
│                      addition to the log file).                              │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## pyani-plus_export-run

### Tool Description
Export any single run from the given pyANI-plus SQLite3 database.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyani-plus:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/pyani-plus/pyani-plus
- **Package**: https://anaconda.org/channels/bioconda/packages/pyani-plus/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pyani-plus export-run [OPTIONS]                                         
                                                                                
 Export any single run from the given pyANI-plus SQLite3 database.              
                                                                                
 The output directory must already exist. Any pre-existing files will be        
 overwritten.                                                                   
 The matrix output files are named <method>_<property>.tsv while the long form  
 is named <method>_run_<run-id>.tsv and will include the query and subject      
 genomes and all the comparison properties as columns.                          
 Incomplete runs will return an error. There will be no output for empty run.   
 For partial runs the long form table will be exported, but not the matrices.   
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --database  -d      FILE                 Path to pyANI-plus SQLite3       │
│                                             database.                        │
│                                             [required]                       │
│ *  --outdir    -o      DIRECTORY            Output directory. Created if     │
│                                             does not already exist.          │
│                                             [required]                       │
│    --run-id    -r      INTEGER              Which run from the database      │
│                                             (defaults to latest).            │
│    --label             [md5|filename|stem]  How to label the genomes.        │
│                                             [default: stem]                  │
│    --help      -h                           Show this message and exit.      │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Debugging ──────────────────────────────────────────────────────────────────╮
│ --log          FILE  Where to record log(s). Use '-' for no logging.         │
│                      [default: -]                                            │
│ --debug              Show debugging level logging at the terminal (in        │
│                      addition to the log file).                              │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## pyani-plus_plot-run

### Tool Description
Plot heatmaps and distributions for any single run.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyani-plus:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/pyani-plus/pyani-plus
- **Package**: https://anaconda.org/channels/bioconda/packages/pyani-plus/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pyani-plus plot-run [OPTIONS]                                           
                                                                                
 Plot heatmaps and distributions for any single run.                            
                                                                                
 The output directory must already exist. The heatmap files will be named       
 <method>_<property>.<extension> and any pre-existing files will be             
 overwritten.                                                                   
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --database  -d      FILE                 Path to pyANI-plus SQLite3       │
│                                             database.                        │
│                                             [required]                       │
│ *  --outdir    -o      DIRECTORY            Output directory. Created if     │
│                                             does not already exist.          │
│                                             [required]                       │
│    --run-id    -r      INTEGER              Which run from the database      │
│                                             (defaults to latest).            │
│    --label             [md5|filename|stem]  How to label the genomes.        │
│                                             [default: stem]                  │
│    --help      -h                           Show this message and exit.      │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Debugging ──────────────────────────────────────────────────────────────────╮
│ --log          FILE  Where to record log(s). Use '-' for no logging.         │
│                      [default: -]                                            │
│ --debug              Show debugging level logging at the terminal (in        │
│                      addition to the log file).                              │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## pyani-plus_plot-run-comp

### Tool Description
Plot comparisons between multiple runs.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyani-plus:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/pyani-plus/pyani-plus
- **Package**: https://anaconda.org/channels/bioconda/packages/pyani-plus/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pyani-plus plot-run-comp [OPTIONS]                                      
                                                                                
 Plot comparisons between multiple runs.                                        
                                                                                
 The output directory must already exist. The scatter plots will be named       
 <method>_<property>_<run-id>_vs_*.<extension> and any pre-existing files will  
 be overwritten.                                                                
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --database  -d      FILE                  Path to pyANI-plus SQLite3      │
│                                              database.                       │
│                                              [required]                      │
│ *  --outdir    -o      DIRECTORY             Output directory. Created if    │
│                                              does not already exist.         │
│                                              [required]                      │
│ *  --run-ids           TEXT                  Which runs (comma separated     │
│                                              list, reference first)?         │
│                                              [default: None]                 │
│                                              [required]                      │
│    --columns           INTEGER RANGE [x>=0]  How many columns to use when    │
│                                              tiling plots of multiple runs.  │
│                                              Default 0 means automatically   │
│                                              tries for square tiling.        │
│                                              [default: 0]                    │
│    --help      -h                            Show this message and exit.     │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Debugging ──────────────────────────────────────────────────────────────────╮
│ --log          FILE  Where to record log(s). Use '-' for no logging.         │
│                      [default: -]                                            │
│ --debug              Show debugging level logging at the terminal (in        │
│                      addition to the log file).                              │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## pyani-plus_classify

### Tool Description
Classify genomes into clusters based on ANI results.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyani-plus:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/pyani-plus/pyani-plus
- **Package**: https://anaconda.org/channels/bioconda/packages/pyani-plus/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pyani-plus classify [OPTIONS]                                           
                                                                                
 Classify genomes into clusters based on ANI results.                           
                                                                                
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --database  -d      FILE                 Path to pyANI-plus SQLite3       │
│                                             database.                        │
│                                             [required]                       │
│ *  --outdir    -o      DIRECTORY            Output directory. Created if     │
│                                             does not already exist.          │
│                                             [required]                       │
│    --run-id    -r      INTEGER              Which run from the database      │
│                                             (defaults to latest).            │
│    --label             [md5|filename|stem]  How to label the genomes.        │
│                                             [default: stem]                  │
│    --help      -h                           Show this message and exit.      │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Method parameters ──────────────────────────────────────────────────────────╮
│ --coverage-edges        TEXT                       How to resolve            │
│                                                    asymmetrical ANI coverage │
│                                                    results for edges in the  │
│                                                    graph (min, max or mean). │
│                                                    [default: min]            │
│ --score-edges           TEXT                       How to resolve            │
│                                                    asymmetrical ANI          │
│                                                    identity/tANI results for │
│                                                    edges in the graph (min,  │
│                                                    max or mean).             │
│                                                    [default: mean]           │
│ --vertical-line         FLOAT RANGE [x<=1.0]       Threshold for red         │
│                                                    vertical line at          │
│                                                    identity/tANI.            │
│                                                    [default: 0.95]           │
│ --cov-min               FLOAT RANGE [0.0<=x<=1.0]  minimum %coverage for an  │
│                                                    edge                      │
│                                                    [default: 0.5]            │
│ --mode                  [identity|tANI]            Classify mode intended to │
│                                                    identify cliques within a │
│                                                    set of genomes.           │
│                                                    [default: identity]       │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Debugging ──────────────────────────────────────────────────────────────────╮
│ --log          FILE  Where to record log(s). Use '-' for no logging.         │
│                      [default: -]                                            │
│ --debug              Show debugging level logging at the terminal (in        │
│                      addition to the log file).                              │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## pyani-plus_anim

### Tool Description
Execute ANIm calculations, logged to a pyANI-plus SQLite3 database.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyani-plus:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/pyani-plus/pyani-plus
- **Package**: https://anaconda.org/channels/bioconda/packages/pyani-plus/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pyani-plus anim [OPTIONS] FASTA                                         
                                                                                
 Execute ANIm calculations, logged to a pyANI-plus SQLite3 database.            
                                                                                
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    fasta      PATH  Directory of FASTA files (extensions .fa, .fas,        │
│                       .fasta, .fna).                                         │
│                       [required]                                             │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --database   -d      FILE           Path to pyANI-plus SQLite3 database.  │
│                                        [required]                            │
│    --name               TEXT           Run name. Default is 'N genomes using │
│                                        METHOD'.                              │
│    --create-db                         Create database if does not exist.    │
│    --executor           [local|slurm]  How should the internal tools be run? │
│                                        [default: local]                      │
│    --help       -h                     Show this message and exit.           │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Method parameters ──────────────────────────────────────────────────────────╮
│ --mode        [mum|maxmatch]  Nucmer mode for ANIm. [default: mum]           │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Debugging ──────────────────────────────────────────────────────────────────╮
│ --temp         DIRECTORY  Directory to use for intermediate files, which for │
│                           debugging purposes will not be deleted. For        │
│                           clusters this must be on a shared drive. Default   │
│                           behaviour is to use a system specified temporary   │
│                           directory (specific to the compute-node when using │
│                           a cluster) and remove this afterwards.             │
│ --wtemp        DIRECTORY  Directory to use for temporary workflow            │
│                           coordination files, which for debugging purposes   │
│                           will not be deleted. For clusters this must be on  │
│                           a shared drive. Default behaviour is to use a      │
│                           system specified temporary directory (for the      │
│                           local executor) or a temporary directory under the │
│                           present direct (for clusters), and remove this     │
│                           afterwards.                                        │
│ --log          FILE       Where to record log(s). Use '-' for no logging.    │
│                           Default is no logging for the local executor, but  │
│                           otherwise "pyani-plus.log".                        │
│ --debug                   Show debugging level logging at the terminal (in   │
│                           addition to the log file).                         │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## pyani-plus_dnadiff

### Tool Description
Execute mumer-based dnadiff calculations, logged to a pyANI-plus SQLite3 database.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyani-plus:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/pyani-plus/pyani-plus
- **Package**: https://anaconda.org/channels/bioconda/packages/pyani-plus/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pyani-plus dnadiff [OPTIONS] FASTA                                      
                                                                                
 Execute mumer-based dnadiff calculations, logged to a pyANI-plus SQLite3       
 database.                                                                      
                                                                                
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    fasta      PATH  Directory of FASTA files (extensions .fa, .fas,        │
│                       .fasta, .fna).                                         │
│                       [required]                                             │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --database   -d      FILE           Path to pyANI-plus SQLite3 database.  │
│                                        [required]                            │
│    --name               TEXT           Run name. Default is 'N genomes using │
│                                        METHOD'.                              │
│    --create-db                         Create database if does not exist.    │
│    --executor           [local|slurm]  How should the internal tools be run? │
│                                        [default: local]                      │
│    --help       -h                     Show this message and exit.           │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Debugging ──────────────────────────────────────────────────────────────────╮
│ --temp         DIRECTORY  Directory to use for intermediate files, which for │
│                           debugging purposes will not be deleted. For        │
│                           clusters this must be on a shared drive. Default   │
│                           behaviour is to use a system specified temporary   │
│                           directory (specific to the compute-node when using │
│                           a cluster) and remove this afterwards.             │
│ --wtemp        DIRECTORY  Directory to use for temporary workflow            │
│                           coordination files, which for debugging purposes   │
│                           will not be deleted. For clusters this must be on  │
│                           a shared drive. Default behaviour is to use a      │
│                           system specified temporary directory (for the      │
│                           local executor) or a temporary directory under the │
│                           present direct (for clusters), and remove this     │
│                           afterwards.                                        │
│ --log          FILE       Where to record log(s). Use '-' for no logging.    │
│                           Default is no logging for the local executor, but  │
│                           otherwise "pyani-plus.log".                        │
│ --debug                   Show debugging level logging at the terminal (in   │
│                           addition to the log file).                         │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## pyani-plus_anib

### Tool Description
Execute ANIb calculations, logged to a pyANI-plus SQLite3 database.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyani-plus:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/pyani-plus/pyani-plus
- **Package**: https://anaconda.org/channels/bioconda/packages/pyani-plus/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pyani-plus anib [OPTIONS] FASTA                                         
                                                                                
 Execute ANIb calculations, logged to a pyANI-plus SQLite3 database.            
                                                                                
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    fasta      PATH  Directory of FASTA files (extensions .fa, .fas,        │
│                       .fasta, .fna).                                         │
│                       [required]                                             │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --database   -d      FILE           Path to pyANI-plus SQLite3 database.  │
│                                        [required]                            │
│    --name               TEXT           Run name. Default is 'N genomes using │
│                                        METHOD'.                              │
│    --create-db                         Create database if does not exist.    │
│    --executor           [local|slurm]  How should the internal tools be run? │
│                                        [default: local]                      │
│    --help       -h                     Show this message and exit.           │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Method parameters ──────────────────────────────────────────────────────────╮
│ --fragsize        INTEGER RANGE [x>=1]  Comparison method fragment size.     │
│                                         [default: 1020]                      │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Debugging ──────────────────────────────────────────────────────────────────╮
│ --temp         DIRECTORY  Directory to use for intermediate files, which for │
│                           debugging purposes will not be deleted. For        │
│                           clusters this must be on a shared drive. Default   │
│                           behaviour is to use a system specified temporary   │
│                           directory (specific to the compute-node when using │
│                           a cluster) and remove this afterwards.             │
│ --wtemp        DIRECTORY  Directory to use for temporary workflow            │
│                           coordination files, which for debugging purposes   │
│                           will not be deleted. For clusters this must be on  │
│                           a shared drive. Default behaviour is to use a      │
│                           system specified temporary directory (for the      │
│                           local executor) or a temporary directory under the │
│                           present direct (for clusters), and remove this     │
│                           afterwards.                                        │
│ --log          FILE       Where to record log(s). Use '-' for no logging.    │
│                           Default is no logging for the local executor, but  │
│                           otherwise "pyani-plus.log".                        │
│ --debug                   Show debugging level logging at the terminal (in   │
│                           addition to the log file).                         │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## pyani-plus_fastani

### Tool Description
Execute fastANI calculations, logged to a pyANI-plus SQLite3 database.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyani-plus:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/pyani-plus/pyani-plus
- **Package**: https://anaconda.org/channels/bioconda/packages/pyani-plus/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pyani-plus fastani [OPTIONS] FASTA                                      
                                                                                
 Execute fastANI calculations, logged to a pyANI-plus SQLite3 database.         
                                                                                
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    fasta      PATH  Directory of FASTA files (extensions .fa, .fas,        │
│                       .fasta, .fna).                                         │
│                       [required]                                             │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --database   -d      FILE           Path to pyANI-plus SQLite3 database.  │
│                                        [required]                            │
│    --name               TEXT           Run name. Default is 'N genomes using │
│                                        METHOD'.                              │
│    --create-db                         Create database if does not exist.    │
│    --executor           [local|slurm]  How should the internal tools be run? │
│                                        [default: local]                      │
│    --help       -h                     Show this message and exit.           │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Method parameters ──────────────────────────────────────────────────────────╮
│ --fragsize        INTEGER RANGE [x>=1]       Comparison method fragment      │
│                                              size.                           │
│                                              [default: 3000]                 │
│ --kmersize        INTEGER RANGE [1<=x<=16]   Comparison method k-mer size    │
│                                              [default: 16]                   │
│ --minmatch        FLOAT RANGE [0.0<=x<=1.0]  Comparison method min-match.    │
│                                              [default: 0.2]                  │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Debugging ──────────────────────────────────────────────────────────────────╮
│ --temp         DIRECTORY  Directory to use for intermediate files, which for │
│                           debugging purposes will not be deleted. For        │
│                           clusters this must be on a shared drive. Default   │
│                           behaviour is to use a system specified temporary   │
│                           directory (specific to the compute-node when using │
│                           a cluster) and remove this afterwards.             │
│ --wtemp        DIRECTORY  Directory to use for temporary workflow            │
│                           coordination files, which for debugging purposes   │
│                           will not be deleted. For clusters this must be on  │
│                           a shared drive. Default behaviour is to use a      │
│                           system specified temporary directory (for the      │
│                           local executor) or a temporary directory under the │
│                           present direct (for clusters), and remove this     │
│                           afterwards.                                        │
│ --log          FILE       Where to record log(s). Use '-' for no logging.    │
│                           Default is no logging for the local executor, but  │
│                           otherwise "pyani-plus.log".                        │
│ --debug                   Show debugging level logging at the terminal (in   │
│                           addition to the log file).                         │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## pyani-plus_sourmash

### Tool Description
Execute sourmash-plugin-branchwater ANI calculations, logged to a pyANI-plus SQLite3 database.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyani-plus:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/pyani-plus/pyani-plus
- **Package**: https://anaconda.org/channels/bioconda/packages/pyani-plus/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pyani-plus sourmash [OPTIONS] FASTA                                     
                                                                                
 Execute sourmash-plugin-branchwater ANI calculations, logged to a pyANI-plus   
 SQLite3 database.                                                              
                                                                                
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    fasta      PATH  Directory of FASTA files (extensions .fa, .fas,        │
│                       .fasta, .fna).                                         │
│                       [required]                                             │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --database   -d      FILE           Path to pyANI-plus SQLite3 database.  │
│                                        [required]                            │
│    --name               TEXT           Run name. Default is 'N genomes using │
│                                        METHOD'.                              │
│    --create-db                         Create database if does not exist.    │
│    --executor           [local|slurm]  How should the internal tools be run? │
│                                        [default: local]                      │
│    --cache              DIRECTORY      Cache location if required for a      │
│                                        method (must be visible to cluster    │
│                                        workers).                             │
│                                        [default: .]                          │
│    --help       -h                     Show this message and exit.           │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Debugging ──────────────────────────────────────────────────────────────────╮
│ --temp         DIRECTORY  Directory to use for intermediate files, which for │
│                           debugging purposes will not be deleted. For        │
│                           clusters this must be on a shared drive. Default   │
│                           behaviour is to use a system specified temporary   │
│                           directory (specific to the compute-node when using │
│                           a cluster) and remove this afterwards.             │
│ --wtemp        DIRECTORY  Directory to use for temporary workflow            │
│                           coordination files, which for debugging purposes   │
│                           will not be deleted. For clusters this must be on  │
│                           a shared drive. Default behaviour is to use a      │
│                           system specified temporary directory (for the      │
│                           local executor) or a temporary directory under the │
│                           present direct (for clusters), and remove this     │
│                           afterwards.                                        │
│ --log          FILE       Where to record log(s). Use '-' for no logging.    │
│                           Default is no logging for the local executor, but  │
│                           otherwise "pyani-plus.log".                        │
│ --debug                   Show debugging level logging at the terminal (in   │
│                           addition to the log file).                         │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Method parameters ──────────────────────────────────────────────────────────╮
│ --scaled          INTEGER RANGE [x>=1]  Sets the compression scaling ratio.  │
│                                         [default: 1000]                      │
│ --kmersize        INTEGER RANGE [x>=1]  Comparison method k-mer size.        │
│                                         [default: 31]                        │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## pyani-plus_external-alignment

### Tool Description
Compute pairwise ANI from given multiple-sequence-alignment (MSA) file.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyani-plus:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/pyani-plus/pyani-plus
- **Package**: https://anaconda.org/channels/bioconda/packages/pyani-plus/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pyani-plus external-alignment [OPTIONS] FASTA                           
                                                                                
 Compute pairwise ANI from given multiple-sequence-alignment (MSA) file.        
                                                                                
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    fasta      PATH  Directory of FASTA files (extensions .fa, .fas,        │
│                       .fasta, .fna).                                         │
│                       [required]                                             │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --database   -d      FILE           Path to pyANI-plus SQLite3 database.  │
│                                        [required]                            │
│    --name               TEXT           Run name. Default is 'N genomes using │
│                                        METHOD'.                              │
│    --create-db                         Create database if does not exist.    │
│    --executor           [local|slurm]  How should the internal tools be run? │
│                                        [default: local]                      │
│    --help       -h                     Show this message and exit.           │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Debugging ──────────────────────────────────────────────────────────────────╮
│ --temp         DIRECTORY  Directory to use for intermediate files, which for │
│                           debugging purposes will not be deleted. For        │
│                           clusters this must be on a shared drive. Default   │
│                           behaviour is to use a system specified temporary   │
│                           directory (specific to the compute-node when using │
│                           a cluster) and remove this afterwards.             │
│ --wtemp        DIRECTORY  Directory to use for temporary workflow            │
│                           coordination files, which for debugging purposes   │
│                           will not be deleted. For clusters this must be on  │
│                           a shared drive. Default behaviour is to use a      │
│                           system specified temporary directory (for the      │
│                           local executor) or a temporary directory under the │
│                           present direct (for clusters), and remove this     │
│                           afterwards.                                        │
│ --log          FILE       Where to record log(s). Use '-' for no logging.    │
│                           Default is no logging for the local executor, but  │
│                           otherwise "pyani-plus.log".                        │
│ --debug                   Show debugging level logging at the terminal (in   │
│                           addition to the log file).                         │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Method parameters ──────────────────────────────────────────────────────────╮
│ *  --alignment        FILE                 FASTA format MSA of the same      │
│                                            genomes (one sequence per genome) │
│                                            [default: None]                   │
│                                            [required]                        │
│    --label            [md5|filename|stem]  How are the sequences in the MSA  │
│                                            labelled vs the FASTA genomes?    │
│                                            [default: stem]                   │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## Metadata
- **Skill**: generated
