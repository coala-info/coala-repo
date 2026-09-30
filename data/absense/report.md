# absense CWL Generation Report

## absense

### Tool Description
A tool for detecting gene absence in genome assemblies using a reference-based approach.

### Metadata
- **Docker Image**: quay.io/biocontainers/absense:1.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/caraweisman/abSENSE
- **Package**: https://anaconda.org/channels/bioconda/packages/absense/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/absense/overview
- **Total Downloads**: 1.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/caraweisman/abSENSE
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/absense:1.0.1--pyhdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:11cbdaacc55cf167b3aa73c02fa17fe791ed2a860012a98d260187921276af25: unpack entry: usr/local/lib/libstdc++.so.6.0.33: unpack to regular file: short write: write /tmp/build-temp-3036553719/rootfs/usr/local/lib/libstdc++.so.6.0.33: no space left on device
```


## Metadata
- **Skill**: generated

## absense_run_absense.py

### Tool Description
The provided text does not contain help information; it is an error log indicating a failure to build or run the container image due to insufficient disk space.

### Metadata
- **Docker Image**: quay.io/biocontainers/absense:1.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/caraweisman/abSENSE
- **Package**: https://anaconda.org/channels/bioconda/packages/absense/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/absense:1.0.1--pyhdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:11cbdaacc55cf167b3aa73c02fa17fe791ed2a860012a98d260187921276af25: unpack entry: usr/local/lib/libstdc++.so.6.0.33: unpack to regular file: short write: write /tmp/build-temp-2825667066/rootfs/usr/local/lib/libstdc++.so.6.0.33: no space left on device
```

## absense_plot_absense.py

### Tool Description
A tool for plotting ABSENSE results. (Note: The provided text is a system error log regarding container extraction and does not contain the actual help documentation or argument definitions for the tool.)

### Metadata
- **Docker Image**: quay.io/biocontainers/absense:1.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/caraweisman/abSENSE
- **Package**: https://anaconda.org/channels/bioconda/packages/absense/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/absense:1.0.1--pyhdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:11cbdaacc55cf167b3aa73c02fa17fe791ed2a860012a98d260187921276af25: unpack entry: usr/local/lib/libstdc++.so.6.0.33: unpack to regular file: short write: write /tmp/build-temp-2165282588/rootfs/usr/local/lib/libstdc++.so.6.0.33: no space left on device
```


## Run_abSENSE.py

### Tool Description
abSENSE arguments

### Metadata
- **Docker Image**: quay.io/biocontainers/absense:1.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/caraweisman/abSENSE
- **Package**: https://anaconda.org/channels/bioconda/packages/absense/overview
- **Validation**: PASS

### Original Help Text
```text
usage: Run_abSENSE.py [-h] --distfile DISTFILE --scorefile SCOREFILE
                      [--Eval EVAL] [--includeonly INCLUDEONLY]
                      [--genelenfile GENELENFILE] [--dblenfile DBLENFILE]
                      [--predall PREDALL] [--out OUT]

abSENSE arguments:

optional arguments:
  -h, --help            show this help message and exit
  --distfile DISTFILE   Required. Name of file containing pairwise
                        evolutionary distances between focal species and each
                        of the other species
  --scorefile SCOREFILE
                        Required. Name of file containing bitscores between
                        focal species gene and orthologs in other species
  --Eval EVAL           Optional. E-value threshold. Scientific notation (e.g.
                        10E-5) accepted. Default 0.001.
  --includeonly INCLUDEONLY
                        Optional. Species whose orthologs' bitscores will be
                        included in fit; all others will be omitted. Default
                        is all species. Format as species names, exactly as in
                        input files, separated by commas (no spaces).
  --genelenfile GENELENFILE
                        Optional. File containing lengths (aa) of all genes to
                        be analyzed. Used to accurately calculate E-value
                        threshold. Default is 400aa for all genes. Only large
                        deviations will qualitatively affect results.
  --dblenfile DBLENFILE
                        Optional. File containing size (aa) of databases on
                        which the anticipated homology searches will be
                        performed. Species-specific. Used to accurately
                        calculate E-value threshold. Default is 400aa/gene *
                        20,000 genes for each species, intended to be the size
                        of an average proteome. Only large deviations will
                        significantly affect results.
  --predall PREDALL     Optional. True: Predicts bitscores and P(detectable)
                        of homologs in all species, including those in which
                        homologs were actually detected. Default is False:
                        only make predictions for homologs that seem to be
                        absent.
  --out OUT             Optional. Name of directory for output data. Default
                        is date and time when analysis was run.
```
