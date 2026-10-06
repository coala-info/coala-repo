# bohra CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| bohra_deps_check | Not completed | Runs, but reports the bohra conda environments as missing; they are not in the image and need a multi-GB conda install. |
| bohra_deps_install | Not completed | Installs many multi-GB conda environments from the network into the container, which a batch run cannot keep. |
| bohra_deps_update | Not completed | Reinstalls many multi-GB conda environments from the network into the container, which a batch run cannot keep. |
| bohra_generate-input | PASS |  |
| bohra_init-databases | Not completed | Setup asks interactive questions and downloads a Kraken2 database (11 MB to 644 GB); check mode only reads environment variables. |
| bohra_test | Not completed | Pipeline, skipped: the self-test runs the full bohra Nextflow pipeline. |

## bohra_generate-input

### Tool Description
Generare input files for the Bohra pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/bohra:3.4.1--pyhdfd78af_0
- **Homepage**: https://github.com/kristyhoran/bohra
- **Package**: https://anaconda.org/channels/bioconda/packages/bohra/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bohra generate-input [OPTIONS]

  Generare input files for the Bohra pipeline.

Options:
  --reads TEXT        Path to search for reads files, e.g. *.f*q.gz
  --contigs TEXT      Path to search for assembly files, e.g. *.f*a.gz
  --isolate_ids TEXT  Path to a file containing at least one column 'Isolate'
                      with isolate names. Optionally add 'species' and other
                      columns you wish to use for further annotation of trees.
  --outname TEXT      Name of the file to write the generated input table to.
  --help              Show this message and exit.

ERROR: No such option: --h Did you mean --help?
```

## bohra_init-databases

### Tool Description
Download and/or setup required databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/bohra:3.4.1--pyhdfd78af_0
- **Homepage**: https://github.com/kristyhoran/bohra
- **Package**: https://anaconda.org/channels/bioconda/packages/bohra/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bohra init-databases [OPTIONS]

Options:
  --setup_databases     Download and/or setup required databases.
  --database_path TEXT  If you select to setup databases, specify the path to
                        download them to.
  --help                Show this message and exit.

ERROR: No such option: --h Did you mean --help?
```

## bohra_test

### Tool Description
Check that bohra is installed correctly and runs as expected.

### Metadata
- **Docker Image**: quay.io/biocontainers/bohra:3.4.1--pyhdfd78af_0
- **Homepage**: https://github.com/kristyhoran/bohra
- **Package**: https://anaconda.org/channels/bioconda/packages/bohra/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bohra test [OPTIONS]

  Check that bohra is installed correctly and runs as expected.

Options:
  --cpus INTEGER         Number of CPUs to use for testing Bohra installation.
  --shovill_ram INTEGER  Amount of RAM to allocate to shovill assembler.
  --wdir TEXT            Working directory for the test run. Default is the
                         current working directory.
  --help                 Show this message and exit.

ERROR: No such option: --h Did you mean --help?
```

## bohra_deps_check

### Tool Description
Help for checking dependencies.

### Metadata
- **Docker Image**: quay.io/biocontainers/bohra:3.4.1--pyhdfd78af_0
- **Homepage**: https://github.com/kristyhoran/bohra
- **Package**: https://anaconda.org/channels/bioconda/packages/bohra/overview
- **Validation**: PASS
- **usage**: https://mdu-phl.github.io/bohra/usage/overview/

- **Conda**: https://anaconda.org/channels/bioconda/packages/bohra/overview
- **Total Downloads**: 88.0K
- **Last updated**: 2026-02-25
- **GitHub**: https://github.com/kristyhoran/bohra
- **Stars**: N/A

### Original Help Text
```text
Usage: bohra deps check [OPTIONS]

  Help for checking dependencies.

Options:
  --tool [any2fasta|meningotype|lissero|mlst|prokka|snpdists|ngmaster|assemblers|emmtyper|seqkit|fastp|kraken2|gubbins|mash|coresnpfilter|iqtree|quicktree|veryfasttree|ska|snippy|mob_suite|panaroo|ectyper|kleborate|stype|abritamr|tbtamr|sonneitype|classify-pangenome|datasmryzr|seqtk|shigapass|cluster|all]
                                  Update only a specific set of tools from a
                                  single environment. Should really only be
                                  used for development and/or testing
                                  purposes.  [default: all]
  --help                          Show this message and exit.
```

## bohra_deps_install

### Tool Description
Help for installing dependencies.

### Metadata
- **Docker Image**: quay.io/biocontainers/bohra:3.4.1--pyhdfd78af_0
- **Homepage**: https://github.com/kristyhoran/bohra
- **Package**: https://anaconda.org/channels/bioconda/packages/bohra/overview
- **Validation**: PASS
- **usage**: https://mdu-phl.github.io/bohra/usage/overview/

- **Conda**: https://anaconda.org/channels/bioconda/packages/bohra/overview
- **Total Downloads**: 88.0K
- **Last updated**: 2026-02-25
- **GitHub**: https://github.com/kristyhoran/bohra
- **Stars**: N/A

### Original Help Text
```text
Usage: bohra deps install [OPTIONS]

  Help for installing dependencies.

Options:
  --tool [any2fasta|meningotype|lissero|mlst|prokka|snpdists|ngmaster|assemblers|emmtyper|seqkit|fastp|kraken2|gubbins|mash|coresnpfilter|iqtree|quicktree|veryfasttree|ska|snippy|mob_suite|panaroo|ectyper|kleborate|stype|abritamr|tbtamr|sonneitype|classify-pangenome|datasmryzr|seqtk|shigapass|cluster|all]
                                  Install only a specific set of tools from a
                                  single environment. Should really only be
                                  used for development and/or testing
                                  purposes.  [default: all]
  --help                          Show this message and exit.
```

## bohra_deps_update

### Tool Description
Help for updateing dependencies.

### Metadata
- **Docker Image**: quay.io/biocontainers/bohra:3.4.1--pyhdfd78af_0
- **Homepage**: https://github.com/kristyhoran/bohra
- **Package**: https://anaconda.org/channels/bioconda/packages/bohra/overview
- **Validation**: PASS
- **usage**: https://mdu-phl.github.io/bohra/usage/overview/

- **Conda**: https://anaconda.org/channels/bioconda/packages/bohra/overview
- **Total Downloads**: 88.0K
- **Last updated**: 2026-02-25
- **GitHub**: https://github.com/kristyhoran/bohra
- **Stars**: N/A

### Original Help Text
```text
Usage: bohra deps update [OPTIONS]

  Help for updateing dependencies.

Options:
  --tool [any2fasta|meningotype|lissero|mlst|prokka|snpdists|ngmaster|assemblers|emmtyper|seqkit|fastp|kraken2|gubbins|mash|coresnpfilter|iqtree|quicktree|veryfasttree|ska|snippy|mob_suite|panaroo|ectyper|kleborate|stype|abritamr|tbtamr|sonneitype|classify-pangenome|datasmryzr|seqtk|shigapass|cluster|all]
                                  Update only a specific set of tools from a
                                  single environment. Should really only be
                                  used for development and/or testing
                                  purposes.  [default: all]
  --help                          Show this message and exit.
```

## Metadata
- **Skill**: generated
