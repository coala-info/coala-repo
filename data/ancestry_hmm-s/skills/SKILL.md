---
name: ancestry_hmm-s
description: Ancestry_HMM-S detects selection in admixed populations by using a Hidden Markov Model to distinguish between neutral ancestry fluctuations and adaptive introgression. Use when user asks to identify loci under selection, quantify selective pressure in hybrid zones, or calculate likelihood ratios for specific selection coefficients.
homepage: https://github.com/jesvedberg/Ancestry_HMM-S
metadata:
  docker_image: "quay.io/biocontainers/ancestry_hmm-s:0.9.0.2--h9948957_6"
---

# ancestry_hmm-s

## Overview
Ancestry_HMM-S (AHMMS) is a specialized tool for detecting selection in admixed populations. It utilizes a Hidden Markov Model to distinguish between neutral ancestry fluctuations and those driven by adaptive introgression. By analyzing genomic data from a population, it can pinpoint specific loci under selection and quantify the selective pressure (s) acting upon them. This tool is essential for researchers studying hybrid zones, recent gene flow, or evolutionary adaptation following hybridization.

## Core Command Usage

The basic execution requires defining the input data, ploidy, population parameters, and a search mode.

### Required Arguments
- `-i [file]`: Input genomic data file.
- `-s [file]`: Sample ID and ploidy specification file.
- `-p [pop] [time] [prop]`: Ancestry pulse definition. **Note:** This must be specified twice to define the two ancestral populations (donor and recipient).
- `--ne [int]`: Effective population size of the admixed population.

### Working Modes
You must select exactly one mode for the analysis:
- `--gss [start] [stop] [step] [s_start] [s_stop]`: Uses Golden Section Search to find the optimal selection coefficient at each site.
- `--grid [start] [stop] [step] [s_start] [s_stop] [s_step]`: Calculates likelihood ratios across a defined grid of positions and selection coefficients.
- `--site [pos] [s]`: Calculates the likelihood ratio for a specific selection coefficient at a single focal site.

## Expert Tips and Best Practices

### Performance Optimization
For most standard analyses, use the following flags to significantly reduce computation time without sacrificing accuracy:
- `--traj 4`: Employs a fast and accurate 4-point approximation for transition rates instead of the slower default forward iteration.
- `--window p 10`: Limits the Markov chain to extend only 10% of the chromosome length in each direction from the focal site. This prevents the tool from processing the entire chromosome for every site, which is usually unnecessary.
- `--window m 0.1`: Alternatively, set the window size in Morgans (e.g., 0.1 Morgan on each side).

### Coordinate Handling
By default, AHMMS uses line numbers in the input file for positions. To use actual chromosomal coordinates:
- Use the `--unit_coords` flag.
- Ensure your `start`, `stop`, and `step` parameters in `--gss` or `--grid` match the coordinate system of your input file.

### Defining the Introgression Pulse
The `-p` flag requires three values: `[Population ID] [Generations since pulse] [Ancestry Proportion]`.
Example for a pulse 100 generations ago with 20% introgression:
`-p 0 100 0.8 -p 1 100 0.2`

### Handling Large Datasets
- **Chromosome Filtering**: Use `--chr [name]` to analyze a specific chromosome if the input file contains multiple.
- **Region Limiting**: Use `--chr_win [start] [stop]` to restrict the analysis to a specific genomic window.
- **Stochastic Trajectories**: For very small values of selection (s), the experimental `--stochastic` mode can be used, though it is significantly slower and requires `--stochastic_reps` (default 10,000).

## Reference documentation
- [Ancestry_HMM-S Manual](./references/github_com_jesvedberg_Ancestry_HMM-S.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_ancestry_hmm-s_overview.md)