---
name: octopus
description: Octopus is a haplotype-aware variant caller that identifies genomic mutations using a unified framework across various sample types. Use when user asks to call germline or somatic variants, perform joint population calling, analyze trios, or identify mutations in polyclone and single-cell mixtures.
homepage: https://github.com/luntergroup/octopus
metadata:
  docker_image: "quay.io/biocontainers/octopus:0.7.4--ha3c1580_2"
---

# octopus

## Overview
Octopus is a sophisticated variant caller that utilizes a unified haplotype-aware framework to identify mutations. Unlike traditional position-based callers, it constructs a tree of haplotypes and uses particle filtering-inspired pruning to explore possible genomic variations efficiently. This skill provides the necessary command-line patterns to execute its six distinct calling models, ranging from individual germline analysis to complex polyclone or single-cell mixtures.

## Core Calling Models
Select the appropriate model using the `--caller` or specific command-line flags based on your sample type:

- **Individual**: For germline variants in a single healthy sample.
- **Population**: For joint calling across small cohorts.
- **Trio**: For germline and de novo mutations in parent-offspring groups.
- **Cancer**: For detecting somatic mutations in paired or unpaired tumor samples.
- **Polyclone**: For samples with unknown mixtures of haploid clones (e.g., bacteria or viruses).
- **Cell**: For sets of single-cell samples from the same individual.

## Common CLI Patterns

### Basic Germline Calling
To call variants on a single BAM file using a reference genome:
```bash
octopus -R reference.fa -I sample.bam -o output.vcf.gz
```

### Somatic (Cancer) Calling
Requires specifying the normal sample to distinguish somatic from germline variants:
```bash
octopus -R reference.fa -I normal.bam tumor.bam --normal normal_sample_name -o cancer.vcf.gz
```

### Targeted Region Calling
Use the `-T` flag to restrict analysis to specific contigs or intervals:
```bash
octopus -R reference.fa -I sample.bam -T 1 to 22 X Y -o targeted.vcf.gz
```

### Using Random Forest Filters
Octopus performs significantly better when using its pre-trained forest resources for filtering:
```bash
FOREST="/path/to/octopus/resources/forests/germline.v0.7.4.forest"
octopus -R reference.fa -I sample.bam --forest $FOREST --threads 8 -o filtered.vcf.gz
```

## Expert Tips
- **Threading**: Use the `--threads` flag to parallelize the workload. Octopus scales well across multiple cores.
- **VCF Version**: Octopus outputs in VCF 4.3 format. Ensure downstream tools are compatible with this specification.
- **Memory Management**: For large datasets or high-coverage samples, monitor RAM usage as the haplotype tree construction can be memory-intensive.
- **Installation**: If not already in the environment, the quickest deployment is via Bioconda: `conda install -c bioconda octopus`.

## Reference documentation
- [Octopus GitHub Repository](./references/github_com_luntergroup_octopus.md)
- [Bioconda Octopus Overview](./references/anaconda_org_channels_bioconda_packages_octopus_overview.md)