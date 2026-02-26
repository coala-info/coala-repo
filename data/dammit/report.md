# dammit CWL Generation Report

## dammit_migrate

### Tool Description
Migrate dammit databases to a new location or format.

### Metadata
- **Docker Image**: quay.io/biocontainers/dammit:1.2--pyh5ca1d4c_0
- **Homepage**: http://dib-lab.github.io/dammit/
- **Package**: https://anaconda.org/channels/bioconda/packages/dammit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dammit/overview
- **Total Downloads**: 37.5K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: dammit migrate [-h] [--destructive] [--database-dir DATABASE_DIR]
                      [--busco-group [metazoa, eukaryota, vertebrata, ...]]
                      [--n_threads N_THREADS] [--config-file CONFIG_FILE]
                      [--busco-config-file BUSCO_CONFIG_FILE]
                      [--verbosity {0,1,2}] [--profile] [--force]
                      [--no-rename] [--full | --nr | --quick]

optional arguments:
  -h, --help            show this help message and exit
  --destructive
  --database-dir DATABASE_DIR
                        Directory to store databases. Existing databases will
                        not be overwritten. By default, the database directory
                        is $HOME/.dammit/databases.
  --busco-group [metazoa, eukaryota, vertebrata, ...]
                        Which BUSCO group to use. Should be chosen based on
                        the organism being annotated. Full list of options is
                        below.
  --n_threads N_THREADS
                        For annotate, number of threads to pass to programs
                        supporting multithreading. For databases, number of
                        simultaneous tasks to execute.
  --config-file CONFIG_FILE
                        A JSON file providing values to override built-in
                        config. Advanced use only!
  --busco-config-file BUSCO_CONFIG_FILE
                        Path to an alternative BUSCO config file; otherwise,
                        BUSCO will attempt to use its default installation
                        which will likely only work on bioconda. Advanced use
                        only!
  --verbosity {0,1,2}   Verbosity level for doit tasks.
  --profile             Profile task execution.
  --force               Ignore missing database tasks.
  --no-rename           Keep original transcript names. Note: make sure your
                        transcript names do not contain unusual characters.
  --full                Run a "complete" annotation; includes uniref90, which
                        is left out of the default pipeline because it is huge
                        and homology searches take a long time.
  --nr                  Also include annotation to NR database, which is left
                        out of the default and "full" pipelines because it is
                        huge and homology searches take a long time.
  --quick               Run a "quick" annotation; excludes the Infernal Rfam
                        tasks, the HMMER Pfam tasks, and the LAST OrthoDB and
                        uniref90 tasks. Best for users just looking to get
                        basic stats and conditional reciprocal best LAST from
                        a protein database.
```


## dammit_databases

### Tool Description
Check for databases and optionally download and prepare them for use. By default, only check their status.

### Metadata
- **Docker Image**: quay.io/biocontainers/dammit:1.2--pyh5ca1d4c_0
- **Homepage**: http://dib-lab.github.io/dammit/
- **Package**: https://anaconda.org/channels/bioconda/packages/dammit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: dammit databases [-h] [--install] [--database-dir DATABASE_DIR]
                        [--busco-group [metazoa, eukaryota, vertebrata, ...]]
                        [--n_threads N_THREADS] [--config-file CONFIG_FILE]
                        [--busco-config-file BUSCO_CONFIG_FILE]
                        [--verbosity {0,1,2}] [--profile] [--force]
                        [--no-rename] [--full | --nr | --quick]

Check for databases and optionally download and prepare them for use. By
default, only check their status.

optional arguments:
  -h, --help            show this help message and exit
  --install             Install missing databases. Downloads and preps where
                        necessary (default: False)
  --database-dir DATABASE_DIR
                        Directory to store databases. Existing databases will
                        not be overwritten. By default, the database directory
                        is $HOME/.dammit/databases. (default:
                        /root/.dammit/databases)
  --busco-group [metazoa, eukaryota, vertebrata, ...]
                        Which BUSCO group to use. Should be chosen based on
                        the organism being annotated. Full list of options is
                        below. (default: metazoa)
  --n_threads N_THREADS
                        For annotate, number of threads to pass to programs
                        supporting multithreading. For databases, number of
                        simultaneous tasks to execute. (default: 1)
  --config-file CONFIG_FILE
                        A JSON file providing values to override built-in
                        config. Advanced use only! (default: None)
  --busco-config-file BUSCO_CONFIG_FILE
                        Path to an alternative BUSCO config file; otherwise,
                        BUSCO will attempt to use its default installation
                        which will likely only work on bioconda. Advanced use
                        only! (default: None)
  --verbosity {0,1,2}   Verbosity level for doit tasks. (default: 0)
  --profile             Profile task execution. (default: False)
  --force               Ignore missing database tasks. (default: False)
  --no-rename           Keep original transcript names. Note: make sure your
                        transcript names do not contain unusual characters.
                        (default: False)
  --full                Run a "complete" annotation; includes uniref90, which
                        is left out of the default pipeline because it is huge
                        and homology searches take a long time. (default:
                        False)
  --nr                  Also include annotation to NR database, which is left
                        out of the default and "full" pipelines because it is
                        huge and homology searches take a long time. (default:
                        False)
  --quick               Run a "quick" annotation; excludes the Infernal Rfam
                        tasks, the HMMER Pfam tasks, and the LAST OrthoDB and
                        uniref90 tasks. Best for users just looking to get
                        basic stats and conditional reciprocal best LAST from
                        a protein database. (default: False)

Available BUSCO groups are: actinobacteria, actinopterygii,
alveolata_stramenophiles, arthropoda, ascomycota, aves, bacillales, bacteria,
bacteroidetes, basidiomycota, betaproteobacteria, clostridia, cyanobacteria,
deltaepsilonsub, dikarya, diptera, embryophyta, endopterygota,
enterobacteriales, euarchontoglires, eukaryota, eurotiomycetes, firmicutes,
fungi, gammaproteobacteria, hymenoptera, insecta, lactobacillales,
laurasiatheria, mammalia, metazoa, microsporidia, nematoda, pezizomycotina,
proteobacteria, protists, rhizobiales, saccharomyceta, saccharomycetales,
sordariomyceta, spirochaetes, tenericutes, tetrapoda, vertebrata
```


## dammit_annotate

### Tool Description
The main annotation pipeline. Calculates assembly stats; runs BUSCO; runs LAST against OrthoDB (and optionally uniref90), HMMER against Pfam, Inferal against Rfam, and Conditional Reciprocal Best-hit Blast against user databases; and aggregates all results in a properly formatted GFF3 file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dammit:1.2--pyh5ca1d4c_0
- **Homepage**: http://dib-lab.github.io/dammit/
- **Package**: https://anaconda.org/channels/bioconda/packages/dammit/overview
- **Validation**: PASS

### Original Help Text
```text
usage: dammit annotate <transcriptome> [OPTIONS]

The main annotation pipeline. Calculates assembly stats; runs BUSCO; runs LAST
against OrthoDB (and optionally uniref90), HMMER against Pfam, Inferal against
Rfam, and Conditional Reciprocal Best-hit Blast against user databases; and
aggregates all results in a properly formatted GFF3 file.

positional arguments:
  transcriptome         FASTA file with the transcripts to be annotated.

optional arguments:
  -h, --help            show this help message and exit
  -n NAME, --name NAME  Base name to use for renaming the input transcripts.
                        The new names will be of the form <name>_<X>. It
                        should not have spaces, pipes, ampersands, or other
                        characters with special meaning to BASH. (default:
                        Transcript)
  -e EVALUE, --evalue EVALUE
                        e-value cutoff for similarity searches. (default:
                        1e-05)
  -o OUTPUT_DIR, --output-dir OUTPUT_DIR
                        Output directory. By default this will be the name of
                        the transcriptome file with `.dammit` appended
                        (default: None)
  --user-databases USER_DATABASES [USER_DATABASES ...]
                        Optional additional protein databases. These will be
                        searched with CRB-blast. (default: [])
  --sshloginfile SSHLOGINFILE
                        Distribute execution across the specified nodes.
                        (default: None)
  --database-dir DATABASE_DIR
                        Directory to store databases. Existing databases will
                        not be overwritten. By default, the database directory
                        is $HOME/.dammit/databases. (default:
                        /root/.dammit/databases)
  --busco-group [metazoa, eukaryota, vertebrata, ...]
                        Which BUSCO group to use. Should be chosen based on
                        the organism being annotated. Full list of options is
                        below. (default: metazoa)
  --n_threads N_THREADS
                        For annotate, number of threads to pass to programs
                        supporting multithreading. For databases, number of
                        simultaneous tasks to execute. (default: 1)
  --config-file CONFIG_FILE
                        A JSON file providing values to override built-in
                        config. Advanced use only! (default: None)
  --busco-config-file BUSCO_CONFIG_FILE
                        Path to an alternative BUSCO config file; otherwise,
                        BUSCO will attempt to use its default installation
                        which will likely only work on bioconda. Advanced use
                        only! (default: None)
  --verbosity {0,1,2}   Verbosity level for doit tasks. (default: 0)
  --profile             Profile task execution. (default: False)
  --force               Ignore missing database tasks. (default: False)
  --no-rename           Keep original transcript names. Note: make sure your
                        transcript names do not contain unusual characters.
                        (default: False)
  --full                Run a "complete" annotation; includes uniref90, which
                        is left out of the default pipeline because it is huge
                        and homology searches take a long time. (default:
                        False)
  --nr                  Also include annotation to NR database, which is left
                        out of the default and "full" pipelines because it is
                        huge and homology searches take a long time. (default:
                        False)
  --quick               Run a "quick" annotation; excludes the Infernal Rfam
                        tasks, the HMMER Pfam tasks, and the LAST OrthoDB and
                        uniref90 tasks. Best for users just looking to get
                        basic stats and conditional reciprocal best LAST from
                        a protein database. (default: False)

Available BUSCO groups are: actinobacteria, actinopterygii,
alveolata_stramenophiles, arthropoda, ascomycota, aves, bacillales, bacteria,
bacteroidetes, basidiomycota, betaproteobacteria, clostridia, cyanobacteria,
deltaepsilonsub, dikarya, diptera, embryophyta, endopterygota,
enterobacteriales, euarchontoglires, eukaryota, eurotiomycetes, firmicutes,
fungi, gammaproteobacteria, hymenoptera, insecta, lactobacillales,
laurasiatheria, mammalia, metazoa, microsporidia, nematoda, pezizomycotina,
proteobacteria, protists, rhizobiales, saccharomyceta, saccharomycetales,
sordariomyceta, spirochaetes, tenericutes, tetrapoda, vertebrata
```

