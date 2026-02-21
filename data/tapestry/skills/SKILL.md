---
name: tapestry
description: Tapestry is a specialized toolset for the final stages of genome assembly.
homepage: https://github.com/johnomics/tapestry
---

# tapestry

## Overview
Tapestry is a specialized toolset for the final stages of genome assembly. It combines long-read mapping, telomere identification, and ploidy estimation to provide a visual overview of an assembly's quality. The workflow is designed for manual curation: users generate a report, interactively filter contigs in a web browser, and then use the tool to generate a "cleaned" final FASTA file.

## Core Workflow

### 1. Generating the Assembly Report
The `weave` command performs the heavy lifting, including read subsampling, mapping (via minimap2), and report generation.

```bash
weave -a assembly.fasta -r reads.fastq.gz -t TTAGGG -o output_directory -c 8
```

**Key Parameters:**
- `-a`: The genome assembly in FASTA format.
- `-r`: Long reads in FASTQ format (must be gzipped).
- `-t`: The telomere sequence (e.g., `TTAGGG`). You can provide multiple sequences separated by spaces.
- `-d`: Read depth to subsample (default is 50x). Lower this for very large assemblies to save time.
- `-l`: Minimum read length for subsampling (default 10,000 bp).
- `-w`: Window size for ploidy calculations.

### 2. Manual Curation
1. Open the `<output>.tapestry_report.html` file in a modern web browser.
2. Use the interactive table to sort and filter contigs based on length, coverage, ploidy, and telomere presence.
3. Once satisfied, use the "Export CSV" feature in the report to save a file (e.g., `assembly_filtered.csv`).

### 3. Creating the Cleaned Assembly
Use the `clean` command to apply the filters defined in your exported CSV to the original FASTA file.

```bash
clean -a assembly.fasta -c assembly_filtered.csv -o filtered_assembly.fasta
```

## Expert Tips and Best Practices

### Handling Large Assemblies
Tapestry is optimized for small genomes (<50 Mb). For larger assemblies:
- **Read Alignments**: By default, read alignments are disabled for assemblies >50 Mb to keep the HTML report size manageable. Use `-f` to force their inclusion, but expect a very large file.
- **Subsampling**: If `weave` is slow, reduce the depth (`-d 20`) or increase the minimum read length (`-l 20000`) to reduce the computational load.

### Telomere Identification
If the telomere sequence is unknown for your organism:
- Spot-check the first and last 2-5 kb of your longest contigs.
- Look for simple hexamer or heptamer repeats.
- You can provide multiple candidates to `weave` using `-t SEQ1 SEQ2`.

### Interpreting Ploidy
Tapestry estimates ploidy by calculating windowed coverage. 
- **Haplotigs**: Contigs with half the expected global coverage are likely alternative haplotypes.
- **Symbionts**: Contigs with significantly higher coverage than the nuclear genome often represent mitochondrial, plastid, or endosymbiont DNA.

### Troubleshooting Dependencies
Tapestry relies on `minimap2` and `samtools` being in your PATH. If running on Apple Silicon (M1/M2/M3), Bioconda packages may fail; in these cases, install the dependencies via Homebrew or source and install Tapestry via `pip`.

## Reference documentation
- [Tapestry GitHub Repository](./references/github_com_johnomics_tapestry.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_tapestry_overview.md)