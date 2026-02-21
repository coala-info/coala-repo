---
name: schavott
description: Schavott is a specialized bioinformatics tool designed for the "live" processing of Nanopore sequencing data.
homepage: http://github.com/emilhaegglund/schavott
---

# schavott

## Overview
Schavott is a specialized bioinformatics tool designed for the "live" processing of Nanopore sequencing data. It allows researchers to observe the progress of genome assembly or scaffolding as data flows from the sequencer, rather than waiting for the run to complete. It functions by watching a local directory for new FAST5 files and triggering processing tasks at defined intervals (based on time or read count).

## Installation and Setup
The most reliable way to install schavott is via Bioconda:
```bash
conda install -c bioconda schavott
```

**Prerequisites:**
- **Python:** Version 2.7 (Note: This tool is legacy and requires a Python 2 environment).
- **Visualization:** A Bokeh server must be running to use the graphical interface.
- **External Tools:** Depending on the mode, you must have `SSPACE-longreads`, `LINKS`, or `minimap`/`miniasm` installed and accessible.

## Core Workflows

### 1. Real-time Scaffolding
Use this mode when you have an existing set of contigs and want to use incoming long reads to join them.

**Using SSPACE-longreads:**
```bash
schavott --run_mode scaffold --scaffolder SSPACE --sspace_path /path/to/SSPACE-longreads.pl --watch ./fast5_pass_dir --contig_file assembly_contigs.fasta
```

**Using LINKS:**
```bash
schavott --run_mode scaffold --scaffolder links --watch ./fast5_pass_dir --contig_file assembly_contigs.fasta
```

### 2. Real-time Assembly
Use this mode to generate a de novo assembly from scratch as reads are generated.

```bash
schavott --run_mode assembly --watch ./fast5_pass_dir --min_read_length 5000 --min_quality 8
```

### 3. Visualization
To monitor the process in a web browser, you must first start the Bokeh server in a separate terminal:
```bash
bokeh serve
```
Then, include the `--plot` flag in your schavott command.

## Command Line Reference

| Argument | Description | Default |
| :--- | :--- | :--- |
| `--run_mode` | Choose `scaffold` or `assembly`. | scaffold |
| `--watch`, `-w` | Directory to monitor for new FAST5 files. | Required |
| `--intensity`, `-i` | Frequency of processing (every Nth read or Nth second). | 100 |
| `--run_mode` (sub) | Use `reads` or `time` to define intensity. | reads |
| `--min_read_length` | Filter out reads shorter than this value. | 5000 |
| `--min_quality` | Filter out reads below this Phred score. | 9 |
| `--skip`, `-j` | Number of initial reads to ignore. | 0 |
| `--output`, `-o` | Prefix for output files. | schavott |

## Expert Tips and Best Practices
- **Resource Management:** Real-time assembly is computationally expensive. If the sequencer is producing data faster than `miniasm` can process it, increase the `--intensity` value (e.g., `-i 500`) to run the assembly less frequently.
- **Data Simulation:** Before a real run, test your pipeline using the included simulation scripts. Use `read_simulation.py` for modern Albacore-basecalled data:
  ```bash
  python read_simulation.py [source_folder] [watch_dir] [start_time] --speed super-sonic --force
  ```
- **Quality Filtering:** For bacterial genomes, setting `--min_read_length 5000` is generally recommended to ensure reads are long enough to resolve repeats during scaffolding.
- **Legacy Support:** If working with "ancient" data (pre-v7.3), use `poretools times` to extract timing information and `move_fast5.py` to simulate the run.

## Reference documentation
- [GitHub Repository: emilhaegglund/schavott](./references/github_com_emilhaegglund_schavott.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_schavott_overview.md)