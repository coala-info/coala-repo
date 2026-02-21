---
name: svision-pro
description: SVision-pro is a structural variant caller that utilizes a neural-network-based instance segmentation framework.
homepage: https://github.com/songbowang125/SVision-pro
---

# svision-pro

## Overview
SVision-pro is a structural variant caller that utilizes a neural-network-based instance segmentation framework. It represents genome-to-genome sequencing differences visually to identify both simple (SSV) and complex (CSV) structural variants. It is particularly effective for comparative genomics, allowing users to differentiate variants between target and control samples (e.g., tumor vs. normal or trio analysis) without requiring pre-existing inference models.

## Core Detection Modes
SVision-pro operates in four primary modes based on the number of base (control) genomes provided:

- **Germline (N=0)**: Standard SV calling on a single target sample.
- **Somatic (N=1)**: Comparative calling between a tumor (target) and normal (base) sample.
- **De Novo (N=2)**: Trio analysis (e.g., child as target; father and mother as base).
- **Genotype (N=N)**: Multi-sample comparison for genotyping across multiple base genomes.

## Command Line Patterns

### 1. Germline Detection
```bash
SVision-pro --target_path target.bam \
            --genome_path ref.fasta \
            --model_path model_liteunet_256.pth \
            --out_path ./output/ \
            --sample_name sample1 \
            --detect_mode germline
```

### 2. Somatic and De Novo Workflows
Comparative modes require a two-step process: running the caller and then extracting the specific calls.

**Somatic Example:**
```bash
# Step 1: Run detection
SVision-pro --target_path tumor.bam --base_path normal.bam \
            --genome_path ref.fasta --model_path model.pth \
            --out_path ./output/ --detect_mode somatic

# Step 2: Extract somatic variants
python extract_op.py --input_vcf ./output/svision_pro.vcf --extract somatic
```

**De Novo Example:**
```bash
# Step 1: Run detection
SVision-pro --target_path child.bam --base_path father.bam mother.bam \
            --genome_path ref.fasta --model_path model.pth \
            --out_path ./output/ --detect_mode denovo

# Step 2: Extract de novo variants
python extract_op.py --input_vcf ./output/svision_pro.vcf --extract denovo
```

## Model Selection and Sensitivity
The tool provides three LiteUnet models (256, 512, 1024) located in `src/pre_process/`. The image size determines the minimum detectable SV frequency:

| Image Size | Min SV Frequency | Recommended Use |
| :--- | :--- | :--- |
| 256 (Default) | 0.04 | Standard conditions; balanced speed/sensitivity. |
| 512 | 0.02 | Higher sensitivity for low-frequency variants. |
| 1024 | 0.01 | Maximum sensitivity; computationally intensive. |

**Note:** When using a non-default model, you must match the `--img_size` parameter to the model file:
`SVision-pro ... --img_size 512 --model_path model_liteunet_512_...pth`

## Expert Tips and Best Practices
- **Access BED Files**: Always use the `--access_path` parameter with the provided BED files (e.g., `hg38.access.10M.bed`) to exclude centromere and heterochromatin regions, which reduces false positives and processing time.
- **Sequence Presets**: Use `--preset` to optimize for your data type: `hifi` (default), `error-prone` (standard long reads), or `asm` (assembly-to-reference).
- **Resource Management**: 
    - Use `--process_num` to set the number of threads.
    - For prediction, use `--device gpu --gpu_id 0` if a CUDA-enabled GPU is available to significantly speed up the neural network inference.
    - If using CPU, tune `--net_cpu_num` (default: 2) to control cores per prediction sub-process.
- **Coverage Filtering**: If working with high-depth data, adjust `--max_coverage` (default: 500) or use `--skip_coverage_filter` if you suspect variants are hidden in high-depth regions.

## Reference documentation
- [SVision-pro GitHub Repository](./references/github_com_songbowang125_SVision-pro.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_svision-pro_overview.md)