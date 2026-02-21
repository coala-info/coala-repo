---
name: phirbo
description: Phirbo (Phage-Host Interaction Search by Rank-Biased Overlap) is a tool designed to identify the most likely prokaryotic hosts for given phage sequences.
homepage: https://github.com/aziele/phirbo
---

# phirbo

## Overview
Phirbo (Phage-Host Interaction Search by Rank-Biased Overlap) is a tool designed to identify the most likely prokaryotic hosts for given phage sequences. Instead of direct phage-host alignment, it compares the similarity profiles of both entities against a shared reference database. By measuring the overlap between these ranked similarity lists, Phirbo provides a robust prediction of phage-host interactions that accounts for taxonomic biases and sequence relatedness.

## Installation and Setup
Install Phirbo via Bioconda or by cloning the repository. It requires Python 3.6+ and the `numpy` and `pandas` libraries.

```bash
# Via Conda
conda install -c bioconda phirbo

# Via GitHub
git clone https://github.com/aziele/phirbo.git
```

## Input Data Preparation
Before running Phirbo, you must generate ranked lists for your phage and host sequences.
1. Perform a sequence similarity search (e.g., BLAST) for your phages and potential hosts against the same reference database of prokaryotic genomes.
2. Create individual text files for every genome.
3. Format the files with one bacterial species per line, ordered by decreasing similarity score.
4. Handle ties (equal ranks) by placing species on the same line, separated by commas.

Example file format (`NC_000866.txt`):
```text
Escherichia coli
Shigella boydii
Shigella flexneri
Yersinia rohdei, Yersinia ruckeri
```

## Command Line Usage
Run Phirbo by providing the directory containing phage lists, the directory containing host lists, and the desired output filename.

```bash
phirbo.py [options] <virus_dir> <host_dir> <output_file>
```

### Key Parameters
- `--p [0-1]`: Controls the "top-weightedness" of the RBO measure. A higher value (e.g., 0.9) puts more weight on the very top of the ranked lists. Default is `0.75`.
- `--k <int>`: Truncates the ranked lists to the top `k` items. Use `--k 0` to disable truncation. Default is `30`.
- `--t <int>`: Sets the number of CPU threads for parallel processing. Default is `32`.

### Output Files
- `<output_file>`: A CSV file containing the single best host prediction for each phage.
- `<output_file>.matrix.csv`: A complete matrix of RBO scores between every phage and every host.

## Expert Tips and Best Practices
- **Consistency is Critical**: Ensure that both the phage and host ranked lists were generated using the exact same reference database and search parameters.
- **Score Filtering**: Phirbo scores range from 0 to 1. For high-confidence predictions, filter the results in the output matrix for scores ≥ 0.8.
- **Handling Large Datasets**: If processing thousands of sequences, use the `--k` parameter to truncate lists to the top 20-50 entries. This significantly reduces computation time with minimal impact on prediction accuracy for the most likely hosts.
- **Python Integration**: For custom workflows, use Phirbo as a module:
  ```python
  import phirbo
  phage = phirbo.read_list('virus/phage1.txt')
  host = phirbo.read_list('host/bacteria1.txt')
  score = phirbo.rbo(phage, host, p=0.8)
  ```

## Reference documentation
- [Phirbo GitHub Repository](./references/github_com_aziele_phirbo.md)
- [Bioconda Phirbo Package](./references/anaconda_org_channels_bioconda_packages_phirbo_overview.md)