---
name: moca
description: moca analyzes the evolutionary conservation of transcription factor binding sites to distinguish functional biological motifs from noise. Use when user asks to identify motifs in ChIP-Seq data, calculate motif conservation scores, or generate conservation plots.
homepage: https://github.com/saketkc/moca
metadata:
  docker_image: "quay.io/biocontainers/moca:0.4.3--py27_0"
---

# moca

## Overview
moca (Motif Conservation Analysis) is a specialized bioinformatics tool used to distinguish "true" biological motifs from noise by analyzing their evolutionary signatures. It operates on the hypothesis that functional transcription factor binding sites evolve more slowly than their surrounding flanking sequences. By integrating ChIP-Seq peak data with conservation scores, moca provides both statistical validation and visual representations of motif conservation.

## Core Workflows

### Motif Discovery and Conservation Analysis
The primary entry point for most analyses is the `find_motifs` command, which handles the end-to-end process of locating motifs and calculating conservation.

```bash
moca find_motifs -i peaks.bed -o output_dir -c application.cfg -g hg19 --slop-length 50 --flank-motif 5 --n-motif 3 -t 4 --show-progress
```

**Key Parameters:**
- `-i, --bedfile`: The input ChIP-Seq peaks in BED format.
- `-c, --configuration`: Path to the mandatory configuration file defining genome builds and binary paths.
- `-g, --genome-build`: The specific genome assembly key defined in your config (e.g., hg19, mm10).
- `--slop-length`: The length of the sequence to be extracted around the peak center.
- `--flank-motif`: The number of nucleotides flanking the motif to include in conservation plots.
- `-t, --cores`: Number of parallel threads for MEME jobs.

### Generating Conservation Plots
If you have already performed motif discovery using MEME and Centrimo, you can use the `plot` command to generate the stacked conservation visualizations independently.

```bash
moca plot -c application.cfg -g hg19 \
    --meme-dir ./meme_out \
    --centrimo-dir ./centrimo_out \
    --fimo-dir-sample ./meme_out/fimo_out_1 \
    --fimo-dir-control ./meme_out/fimo_random_1 \
    --name "TranscriptionFactor_Analysis" \
    --flank-motif 5 --motif 1 -o ./plots
```

## Expert Tips and Best Practices

### Configuration Management
moca requires a structured configuration file (`application.cfg`) to locate genome fasta files and MEME binaries. Ensure your config follows this logic:
- Define absolute paths to genome fasta files.
- Specify the exact location of the MEME binary.
- Map short keys (like `hg19`) to these paths so they can be referenced via the `-g` flag.

### MEME Version Compatibility
- **MEME 4.10.2 vs 4.11.0+**: moca relies on `fasta-shuffle-letters`. This was introduced in MEME 4.11.0. If you are using MEME 4.10.2, you must manually ensure an updated version of `fasta-shuffle-letters` is available in your path.
- **Parallelization**: Always utilize the `-t` flag to match your available CPU cores, as MEME discovery is computationally intensive.

### Data Preparation
- **Peak Centering**: moca performs best when peaks are centered. If your BED file contains broad peaks, consider preprocessing them to identify the peak summits.
- **Slop and Flank**: The `--slop-length` determines the search space for MEME, while `--flank-motif` determines the "context" shown in the final conservation plot. A common starting point is a slop of 50-100bp and a flank of 5-10bp.

### Interpreting Results
- **Conservation Delta**: A "true" motif will typically show a distinct "hump" or increase in conservation scores (PhyloP/GERP) exactly over the motif site compared to the immediate flanking regions.
- **Control Sets**: moca uses FIMO control sets (randomly shuffled sequences) to provide a baseline for conservation, helping to filter out high-conservation regions that are not motif-specific.

## Reference documentation
- [moca GitHub Repository](./references/github_com_saketkc_moca.md)
- [moca Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_moca_overview.md)