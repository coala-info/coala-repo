---
name: refgenconf
description: refgenconf manages genomic resources and asset paths through a standardized configuration-based system to ensure pipeline portability. Use when user asks to initialize a genome configuration, list or pull remote assets, retrieve local or remote asset paths, or build custom genomic indexes.
homepage: https://refgenie.databio.org
metadata:
  docker_image: "quay.io/biocontainers/refgenconf:0.12.2--pyhdfd78af_0"
---

# refgenconf

## Overview
The `refgenconf` skill (interfaced via the `refgenie` CLI) provides a standardized way to manage genomic resources like FASTA files, Bowtie2 indexes, and BWA indexes. It eliminates hard-coded paths in scripts by using a configuration-based "seek" mechanism, ensuring that bioinformatics pipelines remain portable across different computing environments.

## Core Workflows

### Initialization
Before using refgenie locally, you must initialize a configuration file and point the environment variable to it.
```bash
export REFGENIE='genome_config.yaml'
refgenie init -c $REFGENIE
```

### Asset Discovery and Retrieval
To find and download assets from the default reference server:
1. **List remote assets**: `refgenie listr`
2. **Download (Pull) an asset**: `refgenie pull <genome>/<asset>`
   *Example*: `refgenie pull hg38/bowtie2_index`
3. **Retrieve local path (Seek)**: `refgenie seek <genome>/<asset>`
   *Example*: `refgenie seek hg38/fasta`

### Remote Operations
For cloud-based workflows where assets are hosted on S3 or web servers, use `seekr` to get the remote URI without downloading the full file:
* **Get remote path**: `refgenie seekr <genome>/<asset>`
* **Specify cloud class**: `refgenie seekr hg38/fasta --remote-class s3`

### Building Custom Assets
If a specific genome or index is not available on the server, build it locally using the scripted recipes:
* **Build asset**: `refgenie build <custom_genome>/<asset_type>`
  *Example*: `refgenie build my_virus/bwa_index`

## Python API Usage
For script integration, use the `RefGenConf` object to programmatically access paths:
```python
import refgenconf
rgc = refgenconf.RefGenConf("genome_config.yaml")
# Get path to a specific asset
fasta_path = rgc.seek("hg38", "fasta")
```

## Best Practices
* **Environment Variables**: Always set `export REFGENIE=/path/to/config.yaml` in your `.bashrc` or workflow profile to avoid passing the `-c` flag repeatedly.
* **Alias Management**: Use aliases (e.g., `hg38`) to refer to genomes, but be aware that refgenie validates these against sequence-derived identifiers (digests) to ensure data integrity.
* **Portability**: When writing scripts, never hard-code `/home/user/data/hg38.fa`. Instead, use `$(refgenie seek hg38/fasta)` to ensure the script works on any machine with refgenie configured.

## Reference documentation
- [Introduction - Refgenie](./references/refgenie_databio_org_en_latest.md)
- [refgenconf - bioconda](./references/anaconda_org_channels_bioconda_packages_refgenconf_overview.md)