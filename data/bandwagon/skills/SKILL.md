---
name: bandwagon
description: BandWagon is a Python-based tool designed to predict and visualize DNA migration patterns from restriction enzyme digestions.
homepage: https://github.com/Edinburgh-Genome-Foundry/bandwagon
---

# bandwagon

## Overview
BandWagon is a Python-based tool designed to predict and visualize DNA migration patterns from restriction enzyme digestions. It bridges the gap between sequence analysis and lab results by simulating how fragments will appear on an agarose gel. It supports hundreds of enzymes via BioPython, handles both linear and circular constructs, and allows for the creation of custom molecular weight ladders to match specific laboratory standards.

## Installation and Setup
BandWagon can be installed via pip or conda. For interactive visualization features, the bokeh extra is required.

```bash
# Standard installation
pip install bandwagon

# Installation with interactive plotting support
pip install bandwagon[bokeh]

# Conda installation
conda install -c bioconda bandwagon
```

## Core Python API Usage

### 1. Computing Digestion Fragments
The `compute_digestion_bands` function is the primary engine for calculating fragment sizes.

*   **Linear vs. Circular**: Always specify the topology. For plasmids, `linear=False` ensures the junction fragment (crossing the 0-index) is correctly calculated.
*   **Enzyme Mixes**: Pass a list of enzyme names to simulate double or multiple digestions.

```python
from bandwagon import compute_digestion_bands

# Circular plasmid digestion
bands = compute_digestion_bands(sequence, ["EcoRI", "BamHI"], linear=False)
```

### 2. Visualizing Gel Patterns
To create a plot, you typically define a `BandsPattern` for each lane and group them in a `BandsPatternsSet`.

*   **Ladders**: Use the built-in `LADDER_100_to_4k` or define a custom one.
*   **Plotting**: The `.plot()` method returns a Matplotlib axis object for further customization.

```python
from bandwagon import BandsPattern, BandsPatternsSet, LADDER_100_to_4k

# Define lanes
lane1 = BandsPattern([500, 1200, 3000], LADDER_100_to_4k, label="Sample A")
lane2 = BandsPattern([800, 2200], LADDER_100_to_4k, label="Sample B")

# Create set and plot
patterns_set = BandsPatternsSet(patterns=[LADDER_100_to_4k, lane1, lane2], ladder=LADDER_100_to_4k)
ax = patterns_set.plot()
ax.figure.savefig("gel_simulation.png")
```

### 3. Batch Processing and Reporting
For high-throughput workflows, use `plot_records_digestions` to generate multi-page PDF reports from Biopython records.

```python
from bandwagon import plot_records_digestions, LADDER_100_to_4k

# Generates a PDF with one page per construct/digestion combination
plot_records_digestions(
    records=my_records, 
    digestions=[('EcoRI',), ('BamHI', 'XbaI')], 
    ladder=LADDER_100_to_4k, 
    target="digestions_report.pdf"
)
```

## Expert Tips and Best Practices
*   **Custom Ladders**: If your lab uses a specific commercial ladder not in the library, define it using a dictionary of `{actual_size: migration_distance}`. The migration distance can be in any unit (pixels, mm) as it is used for relative interpolation.
*   **Troubleshooting**: Use the PDF reporting feature (`plot_records_digestions`) when troubleshooting unexpected gel results; it provides annotations showing exactly where in the sequence the bands are formed.
*   **Interactive Plots**: When working in Jupyter notebooks, use the Bokeh backend for interactive exploration of band sizes by hovering over the gel image.
*   **Sequence Formats**: While the library accepts raw strings, it is best practice to use Biopython `SeqRecord` objects to maintain metadata when generating complex reports.

## Reference documentation
- [BandWagon GitHub README](./references/github_com_Edinburgh-Genome-Foundry_BandWagon.md)
- [Bioconda BandWagon Overview](./references/anaconda_org_channels_bioconda_packages_bandwagon_overview.md)