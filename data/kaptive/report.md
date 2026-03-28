# kaptive CWL Generation Report

## kaptive_In

### Tool Description
In silico serotyping

### Metadata
- **Docker Image**: quay.io/biocontainers/kaptive:3.1.0--pyhdfd78af_0
- **Homepage**: https://kaptive.readthedocs.io/en/latest
- **Package**: https://anaconda.org/channels/bioconda/packages/kaptive/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kaptive/overview
- **Total Downloads**: 54.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/klebgenomics/Kaptive
- **Stars**: N/A
### Original Help Text
```text
usage: kaptive <command>

[1;36m  _  __    _    ____ _____ _____     _______ 
 | |/ /   / \  |  _ \_   _|_ _\ \   / / ____|
 | ' /   / _ \ | |_) || |  | | \ \ / /|  _|  
 | . \  / ___ \|  __/ | |  | |  \ V / | |___ 
 |_|\_\/_/   \_\_|    |_| |___|  \_/  |_____|                                   

            In silico serotyping           [0m

[1mCommand[0m:
  
    assembly      In silico serotyping of assemblies
    extract       Extract entries from a Kaptive database
    convert       Convert Kaptive results into different formats

[1mOther options[0m:

  -V, --verbose   Print debug messages to stderr
  -v, --version   Show version number and exit
  -h, --help      Show this help message and exit

For more help, visit: [1mhttps://kaptive.readthedocs.io/en/latest/[0m
2026-02-25 05:52:33           parse_args] [1;31m  ERROR] Unknown command "In"; choose from {assembly,extract,convert}[0m
```


## kaptive_assembly

### Tool Description
In silico serotyping of assemblies

### Metadata
- **Docker Image**: quay.io/biocontainers/kaptive:3.1.0--pyhdfd78af_0
- **Homepage**: https://kaptive.readthedocs.io/en/latest
- **Package**: https://anaconda.org/channels/bioconda/packages/kaptive/overview
- **Validation**: PASS

### Original Help Text
```text
usage: kaptive assembly <db> <fasta> [<fasta> ...] [options]

[1;36m  _  __    _    ____ _____ _____     _______ 
 | |/ /   / \  |  _ \_   _|_ _\ \   / / ____|
 | ' /   / _ \ | |_) || |  | | \ \ / /|  _|  
 | . \  / ___ \|  __/ | |  | |  \ V / | |___ 
 |_|\_\/_/   \_\_|    |_| |___|  \_/  |_____|                                   

     In silico serotyping of assemblies    [0m

[1mInputs[0m:

  db path/keyword      Kaptive database path or keyword
  fasta                Assemblies in fasta(.gz|.xz|.bz2) format

[1mOutput options[0m:
  
  Note, text outputs accept '-' for stdout

  -o, --out            Output file to write/append tabular results to (default: stdout)
  -f, --fasta []       Turn on fasta output
                       Accepts a single file or a directory (default: cwd)
  -j, --json []        Turn on JSON lines output
                       Optionally choose file (can be existing) (default: kaptive_results.json)
  -s, --scores []      Dump locus score matrix to tsv (typing will not be performed!)
                       Optionally choose file (can be existing) (default: stdout)
  -p, --plot []        Plot results to "./{assembly}_kaptive_results.{fmt}"
                       Optionally choose a directory (default: cwd)
  --plot-fmt png/svg   Format for locus plots (default: png)
  --no-header          Suppress header line

[1mScoring options[0m:

  --min-cov            Minimum gene %coverage (blen/q_len*100) to be used for scoring (default: 50.0)
  --score-metric       Metric for scoring each locus (default: 0)
                         0: AS (alignment score of genes found)
                         1: mlen (matching bases of genes found)
                         2: blen (aligned bases of genes found)
                         3: q_len (query length of genes found)
  --weight-metric      Weighting for the 1st stage of the scoring algorithm (default: 3)
                         0: No weighting
                         1: Number of genes found
                         2: Number of genes expected
                         3: Proportion of genes found
                         4: blen (aligned bases of genes found)
                         5: q_len (query length of genes found)
  --n-best             Number of best loci from the 1st round of scoring to be
                       fully aligned to the assembly (default: 2)

[1mConfidence options[0m:

  --gene-threshold     Species-level locus gene identity threshold (default: database specific)
  --max-other-genes    Typeable if <= other genes (default: 1)
  --percent-expected   Typeable if >= % expected genes (default: 50)
  --below-threshold    Typeable if any genes are below threshold (default: False)

[1mDatabase options[0m:

  --locus-regex        Python regular-expression to match locus names in db source note
  --type-regex         Python regular-expression to match locus types in db source note
  --filter             Python regular-expression to select loci to include in the database

[1mOther options[0m:

  -V, --verbose        Print debug messages to stderr
  -v, --version        Show version number and exit
  -h, --help           Show this help message and exit
  -t, --threads        Number of alignment threads or 0 for all available (default: 0)

For more help, visit: [1mhttps://kaptive.readthedocs.io/en/latest/[0m
2026-02-25 05:53:03           parse_args] [1;31m  ERROR] Insufficient arguments for kaptive assembly[0m
```


## kaptive_extract

### Tool Description
Extract entries from a Kaptive database

### Metadata
- **Docker Image**: quay.io/biocontainers/kaptive:3.1.0--pyhdfd78af_0
- **Homepage**: https://kaptive.readthedocs.io/en/latest
- **Package**: https://anaconda.org/channels/bioconda/packages/kaptive/overview
- **Validation**: PASS

### Original Help Text
```text
usage: kaptive extract <db> [formats] [options]

[1;36m  _  __    _    ____ _____ _____     _______ 
 | |/ /   / \  |  _ \_   _|_ _\ \   / / ____|
 | ' /   / _ \ | |_) || |  | | \ \ / /|  _|  
 | . \  / ___ \|  __/ | |  | |  \ V / | |___ 
 |_|\_\/_/   \_\_|    |_| |___|  \_/  |_____|                                   

  Extract entries from a Kaptive database  [0m

[1mInputs[0m:
  
  Note, combine with --filter to select loci

  db path/keyword  Kaptive database path or keyword

[1mFormats[0m:
  
  Note, text outputs accept '-' for stdout

  --fna []         Convert to locus nucleotide sequences in fasta format
                   Accepts a single file or a directory (default: cwd)
  --ffn []         Convert to locus gene nucleotide sequences in fasta format
                   Accepts a single file or a directory (default: cwd)
  --faa []         Convert to locus gene protein sequences in fasta format
                   Accepts a single file or a directory (default: cwd)

[1mDatabase options[0m:

  --locus-regex    Python regular-expression to match locus names in db source note
  --type-regex     Python regular-expression to match locus types in db source note
  --filter         Python regular-expression to select loci to include in the database

[1mOther options[0m:

  -V, --verbose    Print debug messages to stderr
  -v, --version    Show version number and exit
  -h, --help       Show this help message and exit

For more help, visit: [1mhttps://kaptive.readthedocs.io/en/latest/[0m
2026-02-25 05:53:22           parse_args] [1;31m  ERROR] Insufficient arguments for kaptive extract[0m
```


## kaptive_convert

### Tool Description
Convert Kaptive results into different formats

### Metadata
- **Docker Image**: quay.io/biocontainers/kaptive:3.1.0--pyhdfd78af_0
- **Homepage**: https://kaptive.readthedocs.io/en/latest
- **Package**: https://anaconda.org/channels/bioconda/packages/kaptive/overview
- **Validation**: PASS

### Original Help Text
```text
usage: kaptive convert <db> <json> [formats] [options]

[1;36m  _  __    _    ____ _____ _____     _______ 
 | |/ /   / \  |  _ \_   _|_ _\ \   / / ____|
 | ' /   / _ \ | |_) || |  | | \ \ / /|  _|  
 | . \  / ___ \|  __/ | |  | |  \ V / | |___ 
 |_|\_\/_/   \_\_|    |_| |___|  \_/  |_____|                                   

Convert Kaptive results into different formats[0m

[1mInputs[0m:

  db path/keyword       Kaptive database path or keyword
  json                  Kaptive JSON lines file or - for stdin

[1mFormats[0m:
  
  Note, text outputs accept '-' for stdout

  -t, --tsv []          Convert to tabular format in file (default: stdout)
  -j, --json []         Convert to JSON lines format in file (default: stdout)
  --fna []              Convert to locus nucleotide sequences in fasta format
                        Accepts a single file or a directory (default: cwd)
  --ffn []              Convert to locus gene nucleotide sequences in fasta format
                        Accepts a single file or a directory (default: cwd)
  --faa []              Convert to locus gene protein sequences in fasta format
                        Accepts a single file or a directory (default: cwd)
  -p, --plot []         Plot results to "./{assembly}_kaptive_results.{fmt}"
                        Optionally choose a directory (default: cwd)
  --plot-fmt png/svg    Format for locus plots (default: png)
  --no-header           Suppress header line

[1mFilter options[0m:
  
  Note, filters take precedence in descending order

  -r, --regex           Python regular-expression to select JSON lines (default: All)
  -l, --loci  [ ...]    Space-separated list to filter locus names (default: All)
  -s, --samples  [ ...]
                        Space-separated list to filter sample names (default: All)

[1mDatabase options[0m:

  --locus-regex         Python regular-expression to match locus names in db source note
  --type-regex          Python regular-expression to match locus types in db source note

[1mOther options[0m:

  -V, --verbose         Print debug messages to stderr
  -v, --version         Show version number and exit
  -h, --help            Show this help message and exit

For more help, visit: [1mhttps://kaptive.readthedocs.io/en/latest/[0m
2026-02-25 05:53:40           parse_args] [1;31m  ERROR] Insufficient arguments for kaptive convert[0m
```


## Metadata
- **Skill**: generated
