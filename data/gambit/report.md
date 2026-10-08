# gambit CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| gambit_dist | PASS |  |
| gambit_query | PASS |  |
| gambit_signatures_create | PASS |  |
| gambit_signatures_info | PASS |  |
| gambit_tree | PASS |  |

## gambit_dist

### Tool Description
Calculate the GAMBIT distances between a set of query geneomes and a set of reference genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/gambit:1.1.0--py39hbcbf7aa_2
- **Homepage**: https://github.com/jlumpe/gambit
- **Package**: https://anaconda.org/channels/bioconda/packages/gambit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gambit/overview
- **Total Downloads**: 14.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jlumpe/gambit
- **Stars**: N/A
### Original Help Text
```text
Usage: gambit dist [OPTIONS]

  Calculate the GAMBIT distances between a set of query geneomes and a set of
  reference genomes.

Options:
  -k INTEGER                  Number of nucleotides to recognize AFTER prefix.
  -p, --prefix NUCS           K-mer prefix.
  -o FILE                     Output file.  [required]
  -q FILE                     Query genome(s) (may be used multiple times).
  --ql FILENAME               File containing paths to query genomes, one per
                              line.
  --qdir DIRECTORY            Parent directory of paths in --ql.
  --qs FILE                   Query signature file.
  -r FILE                     Reference genome (may be used multiple times).
  --rl FILENAME               File containing paths to reference genomes, one
                              per line.
  --rdir DIRECTORY            Parent directory of paths in --rl.
  --rs FILE                   Reference signature file.
  -s, --square                Calculate square distance matrix using query
                              signatures only.
  -d, --use-db                Use reference signatures from database.
  -c, --cores INTEGER RANGE   Number of CPU cores to use.  [x>=1]
  --progress / --no-progress  Show/don't show progress meter.
  --help                      Show this message and exit.
```

## gambit_query

### Tool Description
Predict taxonomy of microbial samples from genome sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/gambit:1.1.0--py39hbcbf7aa_2
- **Homepage**: https://github.com/jlumpe/gambit
- **Package**: https://anaconda.org/channels/bioconda/packages/gambit/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gambit query [OPTIONS] GENOMES...

  Predict taxonomy of microbial samples from genome sequences.

Options:
  -l LISTFILE                     File containing paths to query genomes, one
                                  per line.
  --ldir DIRECTORY                Parent directory of paths in LISTFILE.
  -o, --output FILENAME           File path to write to. If omitted will write
                                  to stdout.
  -f, --outfmt [csv|json|archive]
                                  Format to output results in.
  -s, --sigfile FILE              File containing query signatures, to use in
                                  place of GENOMES.
  --progress / --no-progress      Show/don't show progress meter.
  -c, --cores INTEGER RANGE       Number of CPU cores to use.  [x>=1]
  --help                          Show this message and exit.
```

## gambit_tree

### Tool Description
Estimate a relatedness tree for a set of genomes and output in Newick format.

### Metadata
- **Docker Image**: quay.io/biocontainers/gambit:1.1.0--py39hbcbf7aa_2
- **Homepage**: https://github.com/jlumpe/gambit
- **Package**: https://anaconda.org/channels/bioconda/packages/gambit/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gambit tree [OPTIONS] GENOMES...

  Estimate a relatedness tree for a set of genomes and output in Newick
  format.

Options:
  -l LISTFILE                 File containing paths to genomes files, one per
                              line.
  --ldir DIRECTORY            Parent directory of paths in LISTFILE.
  -s, --sigfile FILE          GAMBIT signatures file.
  -k INTEGER                  Number of nucleotides to recognize AFTER prefix.
  -p, --prefix NUCS           K-mer prefix.
  -c, --cores INTEGER RANGE   Number of CPU cores to use.  [x>=1]
  --progress / --no-progress  Show/don't show progress meter.
  --help                      Show this message and exit.
```

## gambit_signatures_create

### Tool Description
Create k-mer signatures from genome sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/gambit:1.1.0--py39hbcbf7aa_2
- **Homepage**: https://github.com/jlumpe/gambit
- **Package**: https://anaconda.org/channels/bioconda/packages/gambit/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gambit signatures create [OPTIONS] GENOMES...

  Create k-mer signatures from genome sequences.

Options:
  -l LISTFILE                 File containing paths to genome files, one per
                              line.
  --ldir DIRECTORY            Parent directory of paths in LISTFILE.
  -k INTEGER                  Number of nucleotides to recognize AFTER prefix.
  -p, --prefix NUCS           K-mer prefix.
  -o, --output FILE           File path to write to.  [required]
  -m, --meta-json FILENAME    JSON file containing metadata to attach.
  -i, --ids FILENAME          File containing genome IDs (one per line).
  -d, --db-params             Use k/prefix from reference database.
  --progress / --no-progress  Show/don't show progress meter.
  -c, --cores INTEGER RANGE   Number of CPU cores to use.  [x>=1]
  --help                      Show this message and exit.
```

## gambit_signatures_info

### Tool Description
Inspect GAMBIT signature (.gs) files.

### Metadata
- **Docker Image**: quay.io/biocontainers/gambit:1.1.0--py39hbcbf7aa_2
- **Homepage**: https://github.com/jlumpe/gambit
- **Package**: https://anaconda.org/channels/bioconda/packages/gambit/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gambit signatures info [OPTIONS] [FILE]

  Inspect GAMBIT signature (.gs) files.

Options:
  -j, --json    Write output in JSON format.
  -p, --pretty  Prettify JSON output.
  -i, --ids     Write IDs of signatures in file, one per line.
  -d            Use signatures from reference database.
  --help        Show this message and exit.
```

## Metadata
- **Skill**: generated
