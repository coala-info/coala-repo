# checkv CWL Generation Report

## checkv_end_to_end

### Tool Description
Run full pipeline to estimate completeness, contamination, and identify closed genomes

### Metadata
- **Docker Image**: quay.io/biocontainers/checkv:1.0.3--pyhdfd78af_0
- **Homepage**: https://bitbucket.org/berkeleylab/checkv
- **Package**: https://anaconda.org/channels/bioconda/packages/checkv/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/checkv/overview
- **Total Downloads**: 49.6K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Run full pipeline to estimate completeness, contamination, and identify closed genomes

usage: checkv end_to_end <input> <output> [options]

positional arguments:
  input         Input nucleotide sequences in FASTA format (.gz, .bz2 and .xz
                files are supported)
  output        Output directory

options:
  -h, --help    show this help message and exit
  -d PATH       Reference database path. By default the CHECKVDB environment
                variable is used
  --remove_tmp  Delete intermediate files from the output directory
  -t INT        Number of threads to use for prodigal-gv and DIAMOND
  --restart     Overwrite existing intermediate files. By default CheckV
                continues where program left off
  --quiet       Suppress logging messages
```


## checkv_contamination

### Tool Description
Estimate host contamination for integrated proviruses

### Metadata
- **Docker Image**: quay.io/biocontainers/checkv:1.0.3--pyhdfd78af_0
- **Homepage**: https://bitbucket.org/berkeleylab/checkv
- **Package**: https://anaconda.org/channels/bioconda/packages/checkv/overview
- **Validation**: PASS

### Original Help Text
```text
Estimate host contamination for integrated proviruses

usage: checkv contamination <input> <output> [options]

positional arguments:
  input       Input nucleotide sequences in FASTA format (.gz, .bz2 and .xz
              files are supported)
  output      Output directory

options:
  -h, --help  show this help message and exit
  -d PATH     Reference database path. By default the CHECKVDB environment
              variable is used
  -t INT      Number of threads to use for prodigal-gv and hmmsearch
  --restart   Overwrite existing intermediate files. By default CheckV
              continues where program left off
  --quiet     Suppress logging messages
```


## checkv_completeness

### Tool Description
Estimate completeness for genome fragments

### Metadata
- **Docker Image**: quay.io/biocontainers/checkv:1.0.3--pyhdfd78af_0
- **Homepage**: https://bitbucket.org/berkeleylab/checkv
- **Package**: https://anaconda.org/channels/bioconda/packages/checkv/overview
- **Validation**: PASS

### Original Help Text
```text
Estimate completeness for genome fragments

usage: checkv completeness <input> <output> [options]

positional arguments:
  input       Input nucleotide sequences in FASTA format (.gz, .bz2 and .xz
              files are supported)
  output      Output directory

options:
  -h, --help  show this help message and exit
  -d PATH     Reference database path. By default the CHECKVDB environment
              variable is used
  -t INT      Number of threads to use for prodigal-gv and DIAMOND
  --restart   Overwrite existing intermediate files. By default CheckV
              continues where program left off
  --quiet     Suppress logging messages
```


## checkv_complete_genomes

### Tool Description
Identify complete genomes based on terminal repeats and flanking host regions

### Metadata
- **Docker Image**: quay.io/biocontainers/checkv:1.0.3--pyhdfd78af_0
- **Homepage**: https://bitbucket.org/berkeleylab/checkv
- **Package**: https://anaconda.org/channels/bioconda/packages/checkv/overview
- **Validation**: PASS

### Original Help Text
```text
Identify complete genomes based on terminal repeats and flanking host regions

usage: checkv complete_genomes <input> <output> [options]

positional arguments:
  input                 Input nucleotide sequences in FASTA format (.gz, .bz2
                        and .xz files are supported)
  output                Output directory

options:
  -h, --help            show this help message and exit
  --tr_min_len INT      Min length of TR (20)
  --tr_max_count INT    Max occurences of TR per contig (8)
  --tr_max_ambig FLOAT  Max fraction of TR composed of Ns (0.20)
  --tr_max_basefreq FLOAT
                        Max fraction of TR composed of single nucleotide
                        (0.75)
  --kmer_max_freq FLOAT
                        Max kmer frequency (1.5). Computed by splitting genome
                        into kmers, counting occurence of each kmer, and
                        taking the average count. Expected value of 1.0 for no
                        duplicated regions; 2.0 for the same genome repeated
                        back-to-back
  --quiet               Suppress logging messages
```


## checkv_quality_summary

### Tool Description
Summarize results across modules

### Metadata
- **Docker Image**: quay.io/biocontainers/checkv:1.0.3--pyhdfd78af_0
- **Homepage**: https://bitbucket.org/berkeleylab/checkv
- **Package**: https://anaconda.org/channels/bioconda/packages/checkv/overview
- **Validation**: PASS

### Original Help Text
```text
Summarize results across modules

usage: checkv quality_summary <input> <output> [options]

positional arguments:
  input         Input viral sequences in FASTA format
  output        Output directory

options:
  -h, --help    show this help message and exit
  --remove_tmp  Delete intermediate files from the output directory
  --quiet       Suppress logging messages
```


## checkv_download_database

### Tool Description
Download the latest version of CheckV's database

### Metadata
- **Docker Image**: quay.io/biocontainers/checkv:1.0.3--pyhdfd78af_0
- **Homepage**: https://bitbucket.org/berkeleylab/checkv
- **Package**: https://anaconda.org/channels/bioconda/packages/checkv/overview
- **Validation**: PASS

### Original Help Text
```text
Download the latest version of CheckV's database

usage: checkv download_database <destination>

positional arguments:
  destination  Directory where the database will be downloaded to.

options:
  -h, --help   show this help message and exit
  --quiet      Suppress logging messages
```


## checkv_update_database

### Tool Description
Update CheckV's database with your own complete genomes

### Metadata
- **Docker Image**: quay.io/biocontainers/checkv:1.0.3--pyhdfd78af_0
- **Homepage**: https://bitbucket.org/berkeleylab/checkv
- **Package**: https://anaconda.org/channels/bioconda/packages/checkv/overview
- **Validation**: PASS

### Original Help Text
```text
Update CheckV's database with your own complete genomes

usage: checkv update_database <source_db> <dest_db> <genomes> [options]

positional arguments:
  source_db      Path to current CheckV database.
  dest_db        Path to updated CheckV database.
  genomes        FASTA file of complete genomes to add to database, where each
                 nucleotide sequence represents one genome.

options:
  -h, --help     show this help message and exit
  --quiet        Suppress logging messages
  --restart      Overwrite existing database
  --threads INT  Number of threads for prodigal-gv and DIAMOND
```


## Metadata
- **Skill**: generated
