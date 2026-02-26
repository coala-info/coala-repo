# bohra CWL Generation Report

## bohra_deps

### Tool Description
Manage bohra dependencies.

### Metadata
- **Docker Image**: quay.io/biocontainers/bohra:3.4.1--pyhdfd78af_0
- **Homepage**: https://github.com/kristyhoran/bohra
- **Package**: https://anaconda.org/channels/bioconda/packages/bohra/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bohra/overview
- **Total Downloads**: 88.0K
- **Last updated**: 2026-02-25
- **GitHub**: https://github.com/kristyhoran/bohra
- **Stars**: N/A
### Original Help Text
```text
Usage: bohra deps [OPTIONS] COMMAND [ARGS]...

  Manage bohra dependencies.

Options:
  --help  Show this message and exit.

Commands:
  check    Help for checking dependencies.
  install  Help for installing dependencies.
  update   Help for updateing dependencies.

ERROR: No such option: --h Did you mean --help?
```


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


## bohra_run

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/bohra:3.4.1--pyhdfd78af_0
- **Homepage**: https://github.com/kristyhoran/bohra
- **Package**: https://anaconda.org/channels/bioconda/packages/bohra/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: bohra run [OPTIONS] COMMAND [ARGS]...

  Run the Bohra pipeline.

Options:
  --help  Show this message and exit.

Commands:
  amr_typing   Help for the amr_typing pipeline.
  assemble     Help for the assemble pipeline.
  basic        Help for the basic pipeline.
  comparative  Help for the comparative pipeline.
  full         Help for the full pipeline.
  preview      Help for the preview pipeline.
  tb           Help for the tb pipeline.

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


## bohra_utils

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/bohra:3.4.1--pyhdfd78af_0
- **Homepage**: https://github.com/kristyhoran/bohra
- **Package**: https://anaconda.org/channels/bioconda/packages/bohra/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: bohra utils [OPTIONS] COMMAND [ARGS]...

  Bohra utilities.

Options:
  --help  Show this message and exit.

Commands:
  convert-input    Help for convert-input utility.
  generate-input   Help for generate-input utility.
  module-info      Help for module-info utility.
  run-report       Help for run-report utility.
  show-fields      Help for show-fields utility.
  tojson           Help for tojson utility.
  validate-inputs  Help for validate-inputs utility.

ERROR: No such option: --h Did you mean --help?
```

