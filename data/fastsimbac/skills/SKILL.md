---
name: fastsimbac
description: fastsimbac is a high-performance coalescent-based simulator for bacterial populations that models horizontal genetic exchange through gene conversion. Use when user asks to simulate bacterial genomic sequences, model gene conversion events, or generate ancestral recombination graphs in the ms output format.
homepage: https://bitbucket.org/nicofmay/fastsimbac/
metadata:
  docker_image: "quay.io/biocontainers/fastsimbac:1.0.1_bd3ad13d8f79--h503566f_7"
---

# fastsimbac

## Overview
fastsimbac is a high-performance coalescent-based simulator tailored for bacterial populations. Unlike standard eukaryotic simulators that model recombination as crossovers, fastsimbac specifically implements gene conversion, which is the primary mode of horizontal genetic exchange in bacteria. It provides a significantly faster alternative to the original SimBac program, allowing for the simulation of large sample sizes and long genomic regions while maintaining the standard "ms" output format compatible with many downstream population genetics analysis tools.

## Command Line Usage

The basic syntax for fastsimbac follows the structure of Hudson's `ms` but with parameters specific to bacterial evolution:

```bash
fastSimBac <nsam> <nreps> -t <theta> -r <rho> -g <tract_length> [options]
```

### Core Parameters
- **nsam**: Number of samples (sequences) to simulate.
- **nreps**: Number of independent replicates to generate.
- **-t <theta>**: The mutation rate per locus ($4N_0\mu$).
- **-r <rho>**: The recombination rate ($4N_0r$).
- **-g <tract_length>**: The mean length of the gene conversion tract (in base pairs).
- **-l <length>**: The total length of the sequence to simulate (default is 1.0, representing a continuous unit; specify in bp for genomic context).

### Common CLI Patterns

**1. Basic Neutral Simulation**
To simulate 50 sequences with a mutation rate of 100 and a recombination rate of 50, with an average gene conversion tract of 500bp:
```bash
fastSimBac 50 1 -t 100 -r 50 -g 500
```

**2. Simulating Specific Genomic Lengths**
When simulating a specific sequence length (e.g., 100kb), ensure the rates are scaled appropriately or use the `-l` flag to define the physical distance:
```bash
fastSimBac 20 10 -t 0.01 -r 0.005 -g 1000 -l 100000
```

**3. Generating Ancestral Recombination Graphs (ARGs)**
To output the trees (in Newick format) for each non-recombined segment, use the `-T` flag:
```bash
fastSimBac 10 1 -t 10 -r 5 -g 200 -T
```

## Expert Tips
- **Output Redirection**: fastsimbac outputs to `stdout`. Always redirect to a file or pipe into a compression tool for large simulations: `fastSimBac 100 1 -t 200 > simulation_results.txt`.
- **Parameter Scaling**: Remember that $\theta$ and $\rho$ are population-scaled. If you have per-site rates, multiply them by $4N_e$ and the sequence length.
- **Compatibility**: The output is strictly compatible with the `ms` format. You can use tools like `msstats` or custom parsers designed for `ms` to analyze the results.
- **Performance**: For very large chromosomes, memory usage scales with the number of recombination events. If performance bottlenecks occur, consider simulating smaller independent fragments if the biological context allows.

## Reference documentation
- [fastsimbac Overview](./references/anaconda_org_channels_bioconda_packages_fastsimbac_overview.md)
- [fastsimbac Source and Documentation](./references/bitbucket_org_nicofmay_fastsimbac.md)