# dbcanlight CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| dbcanlight_build | Not completed | Downloads and builds the full dbCAN databases (several GB), too large for this test. |
| dbcanlight_conclude | PASS |  |
| dbcanlight_search | PASS |  |

## dbcanlight_build

### Tool Description
Download and build the required databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/dbcanlight:1.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/chtsai0105/dbcanLight/tree/main
- **Package**: https://anaconda.org/channels/bioconda/packages/dbcanlight/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dbcanlight/overview
- **Total Downloads**: 4.9K
- **Last updated**: 2025-08-09
- **GitHub**: https://github.com/chtsai0105/dbcanLight
- **Stars**: N/A
### Original Help Text
```text
usage: dbcanlight build [-h] [-v] [-f] [-t THREADS]

Download and build the required databases.

Clear the database files that already exist in the config folder.
(~/.dbcanlight) Download from the dbcan website and use hmmpress to build the
databases for hmm profile. Use the threads option to download parallelly.

options:
  -h, --help            show this help message and exit
  -v, --verbose         Verbose mode for debug
  -f, --force           Force to rebuild the databases.
  -t, --threads THREADS
                        Number of cpu to use. Will use at most 4 CPUs even if
                        more are specified (default: 4)
```

## dbcanlight_search

### Tool Description
Search a protein FASTA against the CAZyme HMM, substrate HMM or DIAMOND databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/dbcanlight:1.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/chtsai0105/dbcanLight/tree/main
- **Package**: https://anaconda.org/channels/bioconda/packages/dbcanlight/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dbcanlight/overview
- **Total Downloads**: 4.9K
- **Last updated**: 2025-08-09
- **GitHub**: https://github.com/chtsai0105/dbcanLight
- **Stars**: N/A
### Original Help Text
```text
usage: dbcanlight search [-h] [-v] -i file [-o directory]
                         -m {cazyme,sub,diamond} [-e float/AUTO] [-c float]
                         [-t int] [-b int]

The search module takes the protein fasta as input and searches against
protein HMM, substrate HMM or diamond databases.

Use "cazyme" mode to report the CAZyme families predicted by HMM; "sub" mode
to report the potential substrates; and "diamond" mode to report the CAZyme
families predicted by DIAMOND. (--tools hmmer/dbcansub/diamond in the original
run_dbcan)

options:
  -h, --help            show this help message and exit
  -v, --verbose         Verbose mode for debug
  -i, --input file      Plain or gzipped protein fasta
  -o, --output directory
                        Output directory (default: .)
  -m, --mode {cazyme,sub,diamond}
                        Search against cazyme or substrate database
  -e, --evalue float/AUTO
                        Evalue cutoff. Use 1e-15 for hmmsearch and 1e-102 for
                        diamond when specifying AUTO (default: AUTO)
  -c, --coverage float  Coverage cutoff (default: 0.35)
  -t, --threads int     Number of CPU to use (default: 20)
  -b, --blocksize int   Number of sequence to search per batch. Lower the
                        blocksize to use fewer memory. Set as 0 to disable
                        batching (default: 100000, not applicable on diamond)
```

## dbcanlight_conclude

### Tool Description
Conclude the results made by each module into overview.tsv.

### Metadata
- **Docker Image**: quay.io/biocontainers/dbcanlight:1.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/chtsai0105/dbcanLight/tree/main
- **Package**: https://anaconda.org/channels/bioconda/packages/dbcanlight/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dbcanlight/overview
- **Total Downloads**: 4.9K
- **Last updated**: 2025-08-09
- **GitHub**: https://github.com/chtsai0105/dbcanLight
- **Stars**: N/A
### Original Help Text
```text
usage: dbcanlight conclude [-h] [-v] output

Conclude the results made by each module.

Please make sure the predictions made by each module are included in the same
folder and keep the original file names. (since the conclude module rely on
the file name to identify the files and the corresponding tools that made it)
The output "overview.tsv" will be output to the same folder.

positional arguments:
  output         Folder that contains dbcanlight search results

options:
  -h, --help     show this help message and exit
  -v, --verbose  Verbose mode for debug
```

