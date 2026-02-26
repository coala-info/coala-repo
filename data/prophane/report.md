# prophane CWL Generation Report

## prophane_info

### Tool Description
This is prophane version v6.2.6

### Metadata
- **Docker Image**: quay.io/biocontainers/prophane:6.2.6--hdfd78af_0
- **Homepage**: https://gitlab.com/s.fuchs/prophane/
- **Package**: https://anaconda.org/channels/bioconda/packages/prophane/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/prophane/overview
- **Total Downloads**: 25.2K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
This is prophane version v6.2.6

Package install path: /usr/local/bin
General config file: None
snakemake Snakefile: /usr/local/opt/prophane/Snakefile
```


## prophane_init

### Tool Description
Write DB_DIR path for storing prophane databases to general config file.

### Metadata
- **Docker Image**: quay.io/biocontainers/prophane:6.2.6--hdfd78af_0
- **Homepage**: https://gitlab.com/s.fuchs/prophane/
- **Package**: https://anaconda.org/channels/bioconda/packages/prophane/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: prophane init [OPTIONS] DB_DIR

  Write DB_DIR path for storing prophane databases to general config file.

Options:
  --help  Show this message and exit.
```


## prophane_list-dbs

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/prophane:6.2.6--hdfd78af_0
- **Homepage**: https://gitlab.com/s.fuchs/prophane/
- **Package**: https://anaconda.org/channels/bioconda/packages/prophane/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: prophane list-dbs [OPTIONS]
Try 'prophane list-dbs --help' for help.

Error: No such option: --h Did you mean --help?
```


## prophane_list-styles

### Tool Description
Styles available in "/usr/local/opt/prophane/styles"

### Metadata
- **Docker Image**: quay.io/biocontainers/prophane:6.2.6--hdfd78af_0
- **Homepage**: https://gitlab.com/s.fuchs/prophane/
- **Package**: https://anaconda.org/channels/bioconda/packages/prophane/overview
- **Validation**: PASS

### Original Help Text
```text
Styles available in "/usr/local/opt/prophane/styles":

source              version report_style                
            Generic   1.0                   generic.yaml
            Generic 1.0.0               mztab_1_0_0.yaml
                MPA 1.8.x                 mpa_1_8_x.yaml
         MPA_server   3.4    mpa_server_multisample.yaml
Proteome Discoverer   2.5   proteome_discoverer_2_5.yaml
           Scaffold 4.8.x            scaffold_4_8_x.yaml
            generic 1.2.0             mzident_1_2_0.yaml
```


## prophane_prepare-dbs

### Tool Description
download the databases required to execute the tasks in the provided CONFIGFILE

### Metadata
- **Docker Image**: quay.io/biocontainers/prophane:6.2.6--hdfd78af_0
- **Homepage**: https://gitlab.com/s.fuchs/prophane/
- **Package**: https://anaconda.org/channels/bioconda/packages/prophane/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: prophane prepare-dbs [OPTIONS] CONFIGFILE [SNAKEMAKE_ARGS]...

  download the databases required to execute the tasks in the provided
  CONFIGFILE

Options:
  --verbose
  --help     Show this message and exit.
```


## prophane_run

### Tool Description
execute prophane workflow (using snakemake underneath)

### Metadata
- **Docker Image**: quay.io/biocontainers/prophane:6.2.6--hdfd78af_0
- **Homepage**: https://gitlab.com/s.fuchs/prophane/
- **Package**: https://anaconda.org/channels/bioconda/packages/prophane/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: prophane run [OPTIONS] CONFIGFILE [SNAKEMAKE_ARGS]...

  execute prophane workflow (using snakemake underneath)

Options:
  --verbose
  --help     Show this message and exit.
```

