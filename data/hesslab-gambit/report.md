# hesslab-gambit CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| hesslab-gambit_dist | PASS |  |
| hesslab-gambit_query | PASS |  |
| hesslab-gambit_signatures_create | PASS |  |
| hesslab-gambit_signatures_info | PASS |  |

## hesslab-gambit_query

### Tool Description
Predict taxonomy of microbial samples from genome sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/hesslab-gambit:0.5.1--py39hbcbf7aa_1
- **Homepage**: https://github.com/hesslab-gambit/gambit
- **Package**: https://anaconda.org/channels/bioconda/packages/hesslab-gambit/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gambit query [OPTIONS] GENOMES...

  Predict taxonomy of microbial samples from genome sequences.

Options:
  -l LISTFILE                     File containing paths to genomes.
  --ldir DIRECTORY                Parent directory of paths in LISTFILE.
  -o, --output FILENAME           File path to write to. If omitted will write
                                  to stdout.
  -f, --outfmt [csv|json|archive]
                                  Format to output results in.
  -s, --sigfile FILE              File containing query signatures, to use in
                                  place of GENOMES.
  --help                          Show this message and exit.
```

## hesslab-gambit_dist

### Tool Description
Calculate the GAMBIT distances between a set of query genomes and a set of reference genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/hesslab-gambit:0.5.1--py39hbcbf7aa_1
- **Homepage**: https://github.com/hesslab-gambit/gambit
- **Package**: https://anaconda.org/channels/bioconda/packages/hesslab-gambit/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gambit dist [OPTIONS]

  Calculate the GAMBIT distances between a set of query geneomes and a set of
  reference genomes.



Options:
  -k INTEGER         Number of nucleotides to recognize AFTER prefix.
  -p, --prefix NUCS  K-mer prefix.
  -o FILE            Output file.  [required]
  -q FILE            Query genome(s) (may be used multiple times).
  --ql FILENAME      File containing paths to query genomes, one per line.
  --qdir DIRECTORY   Parent directory of files in --ql.
  --qs FILE          Query signature file.
  -r FILE            Reference genome (may be used multiple times).
  --rl FILENAME      File containing paths to reference genomes, one per line.
  --rdir DIRECTORY   Parent directory of files in --rl.
  --rs FILE          Reference signature file.
  -s, --square       Calculate square distance matrix using query signatures
                     only.
  -d, --use-db       Use reference signatures from database.
  --help             Show this message and exit.
```

## hesslab-gambit_signatures_create

### Tool Description
Create k-mer signatures from genome sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/hesslab-gambit:0.5.1--py39hbcbf7aa_1
- **Homepage**: https://github.com/hesslab-gambit/gambit
- **Package**: https://anaconda.org/channels/bioconda/packages/hesslab-gambit/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gambit signatures create [OPTIONS] GENOMES...

  Create k-mer signatures from genome sequences.

Options:
  -l LISTFILE               File containing names/paths of genome files.
  --ldir DIRECTORY          Parent directory of paths in LISTFILE.
  -k INTEGER                Number of nucleotides to recognize AFTER prefix.
  -p, --prefix NUCS         K-mer prefix.
  -o, --output FILE         File path to write to.  [required]
  -m, --meta-json FILENAME  JSON file containing metadata to attach.
  -i, --ids FILENAME        File containing genome IDs (one per line).
  -d, --db-params           Use k/prefix from reference database.
  --help                    Show this message and exit.
```

## hesslab-gambit_signatures_info

### Tool Description
Inspect GAMBIT signature files.

### Metadata
- **Docker Image**: quay.io/biocontainers/hesslab-gambit:0.5.1--py39hbcbf7aa_1
- **Homepage**: https://github.com/hesslab-gambit/gambit
- **Package**: https://anaconda.org/channels/bioconda/packages/hesslab-gambit/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gambit signatures info [OPTIONS] [FILE]

  Inspect GAMBIT signature files.

Options:
  -j, --json    Write output in JSON format.
  -p, --pretty  Prettify JSON output.
  -i, --ids     Write IDs of signatures in file, one per line.
  -d            Use signatures from reference database.
  --help        Show this message and exit.
```
