# vispr CWL Generation Report

## vispr_config

### Tool Description
Example VISPR config. Save this config to a file and edit according to your needs.

### Metadata
- **Docker Image**: quay.io/biocontainers/vispr:0.4.17--pyh7cba7a3_1
- **Homepage**: https://bitbucket.org/liulab/vispr
- **Package**: https://anaconda.org/channels/bioconda/packages/vispr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vispr/overview
- **Total Downloads**: 68.2K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
# ------------------------------------------------------------
# Example VISPR config
# Save this config to a file and edit according to your needs.
# ------------------------------------------------------------

# Provide a reasonable name for your experiment
experiment: myexperiment
# set the species (any identifier accepted by ensembl.org)
species: homo_sapiens
# set the assembly
assembly: hg19

# This section configures the result view in VISPR
targets:
    # per gene results (can be obtained from "mageck test" or "mageck mle")
    results: myexperiment.gene_summary.txt

    # specify if targets are genes (enabling various link-outs)
    genes: true

    # list of targets to hide per default
    # (optional, comment in to use)
    #controls: ribosomal_genes.txt

# This section configures the sample and read count level QC view and the
# RNA count panel in the result view of VISPR
sgrnas:
    # normalized read counts (can be obtained from mageck count)
    counts: myexperiment.count_normalized.txt

    # position and score (e.g. efficiency score) for each sgRNA
    # (optional, comment in to use)
    #annotation: myexperiment.sgrna.bed

    # mapping statistics (can be obtained from mageck count)
    # (optional, comment in to use)
    #mapstats: myexperiment.countsummary.txt

# This section configures the sequence level QC view in VISPR
# (optional, comment in to use)
#fastqc:
#    sample1:
#        # fastqc output for sample1
#        # you can add multiple lines for technical replicates
#        - fastqc/sample1/fastqc_data.txt
#    sample2:
#        # fastqc output for sample2
#        # you can add multiple lines for technical replicates
#        - fastqc/sample2/fastqc_data.txt

# ------------------------------------------------------------
# End example VISPR config
# Save this config to a file and edit according to your needs.
# ------------------------------------------------------------
```


## vispr_server

### Tool Description
Start the VISPR server.

### Metadata
- **Docker Image**: quay.io/biocontainers/vispr:0.4.17--pyh7cba7a3_1
- **Homepage**: https://bitbucket.org/liulab/vispr
- **Package**: https://anaconda.org/channels/bioconda/packages/vispr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vispr server [-h] [--host HOST] [--port PORT] config [config ...]

Start the VISPR server.

positional arguments:
  config       YAML config files. Each file points to the results of one
               MAGeCK run.

optional arguments:
  -h, --help   show this help message and exit
  --host HOST  Host ip location to listen for client connection.
  --port PORT  Port to listen for client connection.
```


## vispr_plot

### Tool Description
Plotting tool for vispr

### Metadata
- **Docker Image**: quay.io/biocontainers/vispr:0.4.17--pyh7cba7a3_1
- **Homepage**: https://bitbucket.org/liulab/vispr
- **Package**: https://anaconda.org/channels/bioconda/packages/vispr/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/lib/python3.6/site-packages/vispr/server.py:23: YAMLLoadWarning: calling yaml.load() without Loader=... is deprecated, as the default Loader is unsafe. Please read https://msg.pyyaml.org/load for full details.
  CAPTIONS = yaml.load(f)
usage: vispr plot [-h] config prefix
vispr plot: error: the following arguments are required: config, prefix
```


## vispr_test

### Tool Description
Run vispr tests

### Metadata
- **Docker Image**: quay.io/biocontainers/vispr:0.4.17--pyh7cba7a3_1
- **Homepage**: https://bitbucket.org/liulab/vispr
- **Package**: https://anaconda.org/channels/bioconda/packages/vispr/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/lib/python3.6/site-packages/vispr/server.py:23: YAMLLoadWarning: calling yaml.load() without Loader=... is deprecated, as the default Loader is unsafe. Please read https://msg.pyyaml.org/load for full details.
  CAPTIONS = yaml.load(f)
usage: vispr test [-h] [--host HOST] [--port PORT] [--update]
vispr test: error: argument -h/--help: ignored explicit argument 'elp'
```


## vispr_archive

### Tool Description
Create a compressed archive for easy distribution of a given config file with all referenced files.

### Metadata
- **Docker Image**: quay.io/biocontainers/vispr:0.4.17--pyh7cba7a3_1
- **Homepage**: https://bitbucket.org/liulab/vispr
- **Package**: https://anaconda.org/channels/bioconda/packages/vispr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vispr archive [-h] config tarfile

Create a compressed archive for easy distribution of a given config file with
all referenced files.

positional arguments:
  config      YAML config file pointing to MAGeCK results.
  tarfile     The tar archive to write. Has to end with .tar, .tar.gz, or
              .tar.bz2

optional arguments:
  -h, --help  show this help message and exit
```

