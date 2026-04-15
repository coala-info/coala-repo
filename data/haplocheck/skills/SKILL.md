---
name: haplocheck
description: Haplocheck is a phylogeny-based tool that identifies contamination in sequencing studies by analyzing mitochondrial DNA content. Use when user asks to detect sample contamination, estimate mitochondrial purity, or identify multiple haplogroups in VCF or BAM files.
homepage: https://github.com/genepi/haplocheck
metadata:
  docker_image: "quay.io/biocontainers/haplocheck:1.3.3--h2a3209d_2"
---

# haplocheck

## Overview
haplocheck is a phylogeny-based tool designed to identify contamination in sequencing studies by analyzing mitochondrial content. It works by detecting polymorphic sites in mtDNA and classifying them into mitochondrial haplogroups using the HaploGrep engine. By identifying the presence of multiple haplogroups within a single sample, it can reliably estimate the level of contamination. While it focuses on the mitochondria, it is highly effective as a proxy for general sample purity in WGS studies, showing high concordance with tools like Verifybamid2.

## Installation
The tool can be installed via Bioconda or by downloading the standalone release.

**Conda installation:**
```bash
conda install bioconda::haplocheck
```

**Manual installation:**
```bash
wget https://github.com/genepi/haplocheck/releases/download/v1.3.3/haplocheck.zip
unzip haplocheck.zip
```

## Common CLI Patterns

### Analyzing VCF Files
The most direct way to use haplocheck is with a VCF file containing mitochondrial variants.

```bash
./haplocheck --out <output-file.txt> <input-vcf>
```

### Analyzing BAM Files
For BAM input, haplocheck typically utilizes the Cloudgene framework to handle the alignment and variant calling steps required before contamination detection.

```bash
# Install Cloudgene to manage the BAM pipeline
curl -s install.cloudgene.io | bash -s 2.3.3
./cloudgene install https://github.com/genepi/haplocheck/releases/download/v1.3.2/haplocheck.zip

# Run the pipeline on BAM files
./cloudgene run haplocheck --files <path-to-bam-folder>
```

## Expert Tips and Best Practices

- **WGS Proxy:** Use haplocheck as a fast alternative to nuclear DNA contamination tools. It is often more computationally efficient because the mitochondrial genome is significantly smaller than the nuclear genome.
- **Tissue Considerations:** Be aware that the accuracy of nDNA contamination estimation via mtDNA can vary depending on the tissue or cell type, as mtDNA copy numbers fluctuate significantly between different biological contexts.
- **Input Requirements:** Ensure your VCF contains the necessary mitochondrial variants. The tool relies on the phylogeny defined by HaploGrep; if the VCF is filtered too aggressively, the haplogroup classification may be less accurate.
- **Output Interpretation:** The tool provides a contamination level estimate. If multiple major haplogroups are detected with significant frequencies, it is a strong indicator of sample mixing.

## Reference documentation
- [haplocheck Overview](./references/anaconda_org_channels_bioconda_packages_haplocheck_overview.md)
- [haplocheck GitHub Repository](./references/github_com_genepi_haplocheck.md)