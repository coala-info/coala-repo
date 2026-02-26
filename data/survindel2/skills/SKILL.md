---
name: survindel2
description: SurVIndel2 detects copy number variations, specifically deletions and tandem duplications, from Next-Generation Sequencing data using paired-end and split-read information. Use when user asks to detect deletions, identify tandem duplications, or call copy number variations from BAM or CRAM files.
homepage: https://github.com/kensung-lab/SurVIndel2
---


# survindel2

## Overview

SurVIndel2 is a specialized bioinformatics tool designed to detect copy number variations (CNVs), specifically deletions and tandem duplications, from Next-Generation Sequencing (NGS) data. It leverages paired-end read information and "hidden split reads" to achieve high accuracy. While the developers recommend their newer tool "SurVeyor" for broader SV types, SurVIndel2 remains a robust choice for targeted deletion/duplication calling in Illumina datasets.

## Usage Instructions

### 1. Input Requirements and Pre-processing
SurVIndel2 requires coordinate-sorted and indexed BAM or CRAM files. For optimal performance, the following tags must be present in the alignment file:
- **MD**: String for mismatching positions.
- **MC**: Mate CIGAR string (added by BWA MEM 0.7.17+).
- **MQ**: Mate mapping quality.

If the **MQ** tag is missing, use Picard's `FixMateInformation` to add it:
```bash
java -jar picard.jar FixMateInformation I=input.bam O=fixed_input.bam
```

### 2. Basic Execution
The primary command runs the initial discovery and calling phase.
```bash
python survindel2.py --threads <N> <BAM_FILE> <WORKDIR> <REFERENCE_FASTA>
```
- `<WORKDIR>`: A directory where intermediate files and results will be stored.
- `<REFERENCE_FASTA>`: The reference genome used for alignment.

### 3. Machine Learning Refinement (Optional)
To significantly reduce false positives, you can apply a pre-trained or custom machine learning model to the initial output.

**Training a model (if not already built):**
```bash
mkdir ml-model
python3 train_classifier.py <comma_separated_training_data_paths> ALL ml-model/
```

**Running the classifier:**
```bash
python run_classifier.py <WORKDIR>/out.vcf <WORKDIR>/out.pass-ml.vcf.gz <WORKDIR>/stats.txt ALL <ML_MODEL_DIR>/
```

### 4. Interpreting Results
The tool generates two primary VCF files in the output directory:
- `out.pass.vcf.gz`: High-confidence calls that passed standard filters.
- `out.vcf.gz`: All candidate calls, including potential false positives.
- `out.pass-ml.vcf.gz`: (If using the classifier) Calls validated by the machine learning model.

## Best Practices and Tips

- **Performance Optimization**: If compiling from source, use the `-DNATIVE=ON` flag with CMake to enable platform-specific optimizations for faster execution.
- **Thread Management**: Use the `--threads` parameter to scale with your hardware; the tool is designed to handle multi-threaded depth computation and assembly.
- **Successor Tool**: Note that for more complex structural variants (insertions, inversions) and genotyped calls, the developers recommend using **SurVeyor** as a more modern alternative.
- **Conda Installation**: The easiest way to manage dependencies is via Bioconda: `conda install bioconda::survindel2`.

## Reference documentation
- [SurVIndel2 GitHub Repository](./references/github_com_kensung-lab_SurVIndel2.md)
- [Bioconda SurVIndel2 Overview](./references/anaconda_org_channels_bioconda_packages_survindel2_overview.md)