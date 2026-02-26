# cansnper2 CWL Generation Report

## cansnper2_CanSNPer2-download

### Tool Description
CanSNPer2-download

### Metadata
- **Docker Image**: quay.io/biocontainers/cansnper2:2.0.6--py_0
- **Homepage**: https://github.com/FOI-Bioinformatics/CanSNPer2
- **Package**: https://anaconda.org/channels/bioconda/packages/cansnper2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cansnper2/overview
- **Total Downloads**: 3.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/FOI-Bioinformatics/CanSNPer2
- **Stars**: N/A
### Original Help Text
```text
usage: CanSNPer2-download [-h] -db  [-s] [-o] [--logs] [--verbose]

CanSNPer2-download

optional arguments:
  -h, --help         show this help message and exit

Required:
  -db , --database   CanSNP database

Download options:
  -s , --source      Source for download (genbank/refseq)
  -o , --outdir      reference genomes folder

Logging and debug options:
  --logs             Specify log directory
  --verbose          Verbose logging
```


## cansnper2_CanSNPer2

### Tool Description
CanSNPer2

### Metadata
- **Docker Image**: quay.io/biocontainers/cansnper2:2.0.6--py_0
- **Homepage**: https://github.com/FOI-Bioinformatics/CanSNPer2
- **Package**: https://anaconda.org/channels/bioconda/packages/cansnper2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: CanSNPer2 [-h] [-db] [-o DIR] [--save_tree] [--no_snpfiles] [--summary]
                 [--refdir] [--workdir] [--read_input]
                 [--min_required_hits MIN_REQUIRED_HITS]
                 [--strictness STRICTNESS] [--keep_going] [--rerun]
                 [--skip_mauve] [--keep_temp] [--tmpdir] [--logdir]
                 [--verbose] [--debug] [--supress]
                 [query [query ...]]

CanSNPer2

optional arguments:
  -h, --help            show this help message and exit

Required arguments:
  query                 File(s) to align (fasta)
  -db , --database      CanSNP database

Output options:
  -o DIR, --outdir DIR  Output directory
  --save_tree           Save tree as PDF using ETE3 (default False)
  --no_snpfiles         Don´t save output files.
  --summary             Output a summary file and tree with all called SNPs
                        not affected by no_snpfiles

Run options:
  --refdir              Specify reference directory
  --workdir             Change workdir default (./)
  --read_input          Select if input is reads not fasta
  --min_required_hits MIN_REQUIRED_HITS
                        Minimum sequential hits to call a SNP!
  --strictness STRICTNESS
                        Percent of snps in path reqired for calling SNP
                        (default 0.7)
  --keep_going          If Error occurs, continue with the rest of samples
  --rerun               Rerun already processed files (else skip if result
                        file exists)
  --skip_mauve          If xmfa files already exists skip step
  --keep_temp           keep temporary files

Logging and debug options:
  --tmpdir              Specify reference directory
  --logdir              Specify log directory
  --verbose             Verbose output
  --debug               Debug output
  --supress             Supress warnings
```


## cansnper2_CanSNPer2-database

### Tool Description
CanSNPer2-database

### Metadata
- **Docker Image**: quay.io/biocontainers/cansnper2:2.0.6--py_0
- **Homepage**: https://github.com/FOI-Bioinformatics/CanSNPer2
- **Package**: https://anaconda.org/channels/bioconda/packages/cansnper2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: CanSNPer2-database [-h] [-db] [--tree] [--annotation] [--references]
                          [--source_type] [--create] [--mod_file] [--parent]
                          [--remove] [--replace] [--export] [--export_format]
                          [-o] [--tmpdir] [--logs] [--verbose] [--debug]
                          [--supress]

CanSNPer2-database

optional arguments:
  -h, --help         show this help message and exit

Required:
  -db , --database   CanSNPer2 database name

Load database:
  --tree             CanSNPer tree source file
  --annotation       CanSNPer snp source file
  --references       File containing all reference genomes listed
  --source_type      Select source file type
  --create           Create new database!

Database modifications:
  --mod_file         File with modifications/update to the tree
  --parent           Node (or nodes matching tree file) from which to
                     update/replace/remove
  --remove           If node is given, instead of replace/update remove branch
                     from node
  --replace          replace node

Export database:
  --export           Export database to text format (exports tree and
                     annotation file)
  --export_format    Select output format [tab, newick]
  -o , --outdir      outdir for database export!

Logging and debug options:
  --tmpdir           Specify tmp directory default (/tmp)
  --logs             Specify log directory
  --verbose          print process info, default no output
  --debug            print debug info
  --supress          supress warnings
```

