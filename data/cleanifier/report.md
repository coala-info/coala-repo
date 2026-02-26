# cleanifier CWL Generation Report

## cleanifier

### Tool Description
The provided text is an error log from a container build/execution process and does not contain help documentation or usage instructions for the 'cleanifier' tool. Consequently, no arguments could be extracted.

### Metadata
- **Docker Image**: quay.io/biocontainers/cleanifier:1.2.0--pyhdfd78af_0
- **Homepage**: https://gitlab.com/rahmannlab/cleanifier
- **Package**: https://anaconda.org/channels/bioconda/packages/cleanifier/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cleanifier/overview
- **Total Downloads**: 2.1K
- **Last updated**: 2025-11-29
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/cleanifier:1.2.0--pyhdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:0cacab098358fffeef7e18bd537907ae734dcfa12ab45fbcd0e62cc9b37264a8: unpack entry: usr/bin/bash: unpack to regular file: short write: write /tmp/build-temp-1902388814/rootfs/usr/bin/bash: no space left on device
```


## Metadata
- **Skill**: generated

## cleanifier

### Tool Description
fast lightweight tool to remove all reads of a species

### Metadata
- **Docker Image**: quay.io/biocontainers/cleanifier:1.2.0--pyhdfd78af_0
- **Homepage**: https://gitlab.com/rahmannlab/cleanifier
- **Package**: https://anaconda.org/channels/bioconda/packages/cleanifier/overview
- **Validation**: PASS
### Original Help Text
```text
usage: cleanifier [-h] [--version] [--debug]
                  {index,filter,info,download,load,remove} ...

cleanifier [cleanifier 1.2.0]: fast lightweight tool to remove all reads of a
species

options:
  -h, --help            Show this help message and exit.
  --version             show version and exit
  --debug, -D           output debugging information (repeat for more)
                        (default: 0)

subcommands:
  For more details of each subcommand, add it as an argument followed by
  --help.

  Available subcommands:
    index               build index of all species' FASTA/Q files
    filter              remove all reads that belong to the specified species
    info                get information about a hash table and dump its data
    download            Download the human index from Zenodo.
    load                Load the index as a shared memory object with the
                        provided name.
    remove              Remove the shared memory object with the provided
                        name.

(c) 2019-2025 by Algorithmic Bioinformatics, Saarland University. MIT License.
```

