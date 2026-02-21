---
name: bicseq2-norm
description: BICseq2-norm is the preprocessing component of the BIC-seq2 pipeline.
homepage: http://compbio.med.harvard.edu/BIC-seq/
---

# bicseq2-norm

## Overview
BICseq2-norm is the preprocessing component of the BIC-seq2 pipeline. It applies a Generalized Additive Model (GAM) to normalize read counts across the genome, accounting for systematic biases such as GC-content and local mappability. This step is mandatory before running `BICseq2-seg.pl` to ensure that the resulting CNV calls are based on true biological signals rather than sequencing artifacts.

## Configuration File Format
The tool requires a tab-delimited configuration file. The first row is a header and is ignored.

| Column | Name | Description |
| :--- | :--- | :--- |
| 1 | chromName | Name of the chromosome (e.g., chr1) |
| 2 | faFile | Path to the reference FASTA file for that chromosome |
| 3 | MapFile | Path to the mappability file (e.g., 50mer/75mer/100mer) |
| 4 | readPosFile | Path to the file containing uniquely mapped read positions |
| 5 | binFileNorm | Output path for the normalized bin data |

## Command Line Usage
After compiling the C source code using `make`, use the Perl wrapper to run the normalization:

```bash
BICseq2-norm.pl [options] <configFile> <output_parameter_file>
```

### Common Options
- `-l=<int>`: Read length (required for accurate bias correction).
- `-s=<int>`: Fragment size.
- `-b=<int>`: Bin size in base pairs (default: 100).
- `--fig=<file.pdf>`: Generates a PDF plot showing Read Count vs. GC-content to verify normalization quality.
- `--tmp=<dir>`: Specify a temporary directory for intermediate files.
- `--p=<float>`: Subsample percentage for model estimation (default: 0.0002). Increase this if the model fails to converge on small datasets.

## Workflow Best Practices
1. **Input Preparation**: Ensure reads are uniquely mapped. Standard BAM files should be filtered for uniqueness and converted to a simple position format (one position per line) for the `readPosFile`.
2. **Mappability Files**: Use mappability files that match your read length (e.g., use 50mer files for 50bp reads).
3. **Resource Management**: Normalization is performed per chromosome as defined in the config file. For large genomes, ensure sufficient disk space for the `binFileNorm` outputs.
4. **Validation**: Always use the `--fig` option during the first run of a new dataset. A successful normalization should show a flattened relationship between GC-content and read counts in the resulting plot.
5. **Downstream Integration**: The files generated in the 5th column (`binFileNorm`) are the direct inputs for `BICseq2-seg.pl`.

## Reference documentation
- [BIC-seq2 Home](./references/compbio_med_harvard_edu_BIC-seq.md)
- [Bioconda bicseq2-norm](./references/anaconda_org_channels_bioconda_packages_bicseq2-norm_overview.md)