---
name: refgenieserver
description: Refgenie is a reference genome manager that standardizes the storage, retrieval, and management of genomic assets through a configuration-driven interface. Use when user asks to initialize a genome configuration, pull or build genomic assets, list local or remote resources, and retrieve absolute paths or remote URLs for bioinformatics files.
homepage: https://refgenie.databio.org/
---

# refgenieserver

## Overview
Refgenie is a reference genome manager that standardizes how bioinformatics assets are stored and accessed. It moves away from arbitrary folder structures and hardcoded paths by using a configuration-driven approach. This skill enables the management of genomic resources through a unified command-line interface, supporting both local asset builds and remote downloads from refgenie-compatible servers. It is particularly useful for ensuring pipeline portability across different computing environments by using "seek" commands to resolve asset locations dynamically.

## Core CLI Patterns

### Initialization and Configuration
Before using refgenie, you must initialize a configuration file and set the environment variable.
```bash
export REFGENIE='genome_config.yaml'
refgenie init -c $REFGENIE
```
To subscribe to a specific asset server:
```bash
refgenie subscribe -s http://refgenomes.databio.org
```

### Asset Registry Paths
Refgenie uses a specific syntax to identify assets: `genome/asset.seek_key:tag`.
- **Example**: `hg38/fasta.fai:default`
- If the tag is omitted, it uses the `default` tag.
- If the seek_key is omitted, it defaults to the asset name.

### Managing Assets
- **List Remote Assets**: `refgenie listr` (View what is available to download).
- **Pull Assets**: `refgenie pull hg38/bowtie2_index` (Downloads and organizes the asset).
- **List Local Assets**: `refgenie list` (View what is currently managed locally).
- **Retrieve Paths**: `refgenie seek hg38/fasta` (Returns the absolute path to the file).

### Building Custom Assets
If an asset is not available on a server, you can build it locally. This requires the `fasta` asset to be present first.
```bash
# Build the base fasta asset
refgenie build hg38/fasta --files fasta=/path/to/hg38.fa

# Build a derived index
refgenie build hg38/bwa_index
```

## Expert Tips and Best Practices

### Remote Mode for Cloud/Ephemeral Environments
Use "remote" commands (ending in 'r') to interact with assets without a local configuration file. This is ideal for Nextflow or Snakemake pipelines running on the cloud.
- `refgenie seekr hg38/fasta` returns a remote URL or S3 path.
- `refgenie populater` can be used to fill configuration templates with remote paths.

### Handling Genome Aliases
Refgenie uses sequence-derived digests to ensure genome integrity, but allows human-readable aliases.
- **View Aliases**: `refgenie alias get`
- **Set New Alias**: `refgenie alias set --aliases my_custom_name --digest <genome_digest>`

### Concurrent Builds
For large-scale infrastructure, use the MapReduce approach to build assets in parallel without config locking issues:
1. Run builds with the map flag: `refgenie build hg38/bowtie2_index --map`
2. Consolidate metadata once all jobs finish: `refgenie build --reduce`

### Asset Provenance
Always build the `fasta` asset first. Most derived assets (bowtie2, bwa, salmon) automatically look for the `fasta` asset in the same namespace. If you need to use a specific version of a fasta file, use the `--assets` argument:
`refgenie build hg38/star_index --assets fasta=hg38/fasta:custom_tag`



## Subcommands

| Command | Description |
|---------|-------------|
| refgenieserver archive | prepare servable archives |
| refgenieserver serve | run the server |

## Reference documentation
- [Refgenie Overview](./references/refgenie_databio_org_en_latest_overview.md)
- [Asset Registry Paths](./references/refgenie_databio_org_en_latest_asset_registry_paths.md)
- [Building Assets](./references/refgenie_databio_org_en_latest_build.md)
- [Genome Aliases](./references/refgenie_databio_org_en_latest_aliases.md)
- [Configuration Guide](./references/refgenie_databio_org_en_latest_genome_config.md)