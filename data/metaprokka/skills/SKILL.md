---
name: metaprokka
description: Metaprokka is a specialized annotation pipeline designed for viral and metagenomic data that utilizes Prodigal-GV for improved gene prediction. Use when user asks to annotate phage genomes, process fragmented metagenomic assemblies, or perform large-scale annotations with reduced disk usage.
homepage: https://github.com/telatin/metaprokka
metadata:
  docker_image: "quay.io/biocontainers/metaprokka:1.15.0--pl5321hdfd78af_0"
---

# metaprokka

## Overview
Metaprokka is a specialized version of the Prokka annotation pipeline designed to handle the unique challenges of viral and metagenomic data. It replaces the standard gene predictor with Prodigal-GV to better handle alternative genetic codes in phages and streamlines output to reduce disk usage in large-scale projects. Use this tool when standard Prokka is insufficient for phage gene calling or when processing fragmented assemblies where disk space and processing speed (specifically avoiding `tbl2asn` bottlenecks) are priorities.

## Installation
Install via Bioconda for the most stable environment:
```bash
conda install -c conda-forge -c bioconda metaprokka
```

## Core Commands and Workflows

### Phage Genome Annotation (`prokka-gv`)
Use `prokka-gv` for isolated phage genomes. It utilizes `prodigal-gv` to detect stop codon reassignments and alternative genetic codes common in bacteriophages.

1. **Download Phrogs HMMs**: Before the first run, download the specialized phage protein database.
   ```bash
   get-phrogs
   ```

2. **Run Annotation**:
   ```bash
   prokka-gv --outdir OUT_DIR --prefix PREFIX --locustag LOCUSTAG --cpus 16 input.fa
   ```

### Metagenome Annotation (`metaprokka`)
Use the `metaprokka` command for fragmented metagenomic assemblies. This mode is optimized to produce fewer output files, omitting the bulky `.fss` and `.fna` files that often consume excessive disk space in large-scale metagenomic projects.

```bash
metaprokka --outdir META_OUT --prefix SAMPLE_01 --cpus 8 metagenome_assembly.fasta
```

## Best Practices and Tips
- **Phrogs Integration**: Always run `get-phrogs` once after installation. `prokka-gv` will automatically detect and use these HMMs if they are present in the conda environment folder.
- **Resource Management**: Use the `--cpus` flag to match your environment; annotation is computationally intensive, especially when running HMM searches against Phrogs.
- **Output Handling**: If you require the standard Prokka output suite (including `.tbl` files for NCBI submission), ensure you are using the correct mode, as `metaprokka` specifically strips down output for efficiency.
- **Fragmented Assemblies**: `metaprokka` is specifically tuned to handle the short contigs and fragments typical of metagenomic binning or raw assemblies better than the default Prokka settings.

## Reference documentation
- [MetaProkka GitHub Repository](./references/github_com_telatin_metaprokka.md)
- [MetaProkka Wiki](./references/github_com_telatin_metaprokka_wiki.md)