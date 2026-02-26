---
name: kmergenie
description: KmerGenie estimates the optimal k-mer length for genome assembly by analyzing k-mer abundance histograms across a range of values. Use when user asks to determine the best k-mer size, predict the number of distinct genomic k-mers, or generate k-mer frequency reports for sequencing data.
homepage: http://kmergenie.bx.psu.edu
---


# kmergenie

## Overview

KmerGenie is a tool that automates the selection of the best k-mer length for genome assembly. It works by computing k-mer abundance histograms for a range of k-values and predicting the number of distinct genomic k-mers in the dataset. The k-mer length that maximizes this number is recommended as the "best k." This skill provides the necessary command-line patterns and interpretive guidance to use the tool effectively, ensuring that the resulting assembly is as contiguous and accurate as possible.

## Usage Instructions

### Basic Execution
To run KmerGenie on a single sequencing file (FASTA, FASTQ, or compressed .gz):
```bash
kmergenie reads.fastq.gz
```

### Processing Multiple Files
If you have multiple libraries or split files, create a text file containing the path to each file (one per line) and pass that list to the tool:
```bash
# Create the list
ls -1 *.fastq.gz > read_list.txt

# Run KmerGenie
kmergenie read_list.txt
```

### Common Options
- **Threads**: Use `-t` to specify the number of threads for faster histogram estimation.
- **Output Prefix**: Use `-o` to change the default prefix (default is "histograms").
- **One-Pass Mode**: Use `--one-pass` to skip the refinement step and finish roughly twice as fast.
- **Diploid Model**: Use `--diploid` only if the sample has moderate-to-high heterozygosity. If the histogram shows only one clear peak, the default haploid model is preferred.

### Interpreting Results
1. **HTML Report**: Always inspect `histograms_report.html`.
2. **Concavity**: The main plot (genomic k-mers vs. k) should be concave with a clear global maximum.
3. **Suboptimal Plots**: If the plot is a plateau or has multiple local maxima, the predicted k might be inaccurate. In these cases, consider trying a larger k-value than predicted.
4. **High Coverage**: If the number of genomic k-mers does not drop at high k-values, restart the analysis with a higher maximum k (e.g., `-k 140`) as the default limit is 120.

## Best Practices
- **Assembler Compatibility**: Do not use KmerGenie for multi-k assemblers like SPAdes or IDBA; these tools have internal heuristics that generally outperform a single predicted k.
- **Input Selection**: Provide the exact set of reads that will be used for contig creation. Include mate-pairs only if the assembler uses them for contig construction (rather than just scaffolding).
- **Memory and Speed**: KmerGenie uses ntCard for histogram estimation, which is highly efficient. Ensure `zlib` and `RScript` are available in the environment for proper execution and report generation.

## Reference documentation
- [KmerGenie README](./references/kmergenie_bx_psu_edu_README.md)
- [KmerGenie Sample Report Analysis](./references/kmergenie_bx_psu_edu_sample_report.html.md)