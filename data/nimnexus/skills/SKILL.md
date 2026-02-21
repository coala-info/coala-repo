---
name: nimnexus
description: The `nimnexus` toolset is designed for the initial processing stages of ChIP-nexus data.
homepage: https://github.com/avsecz/nimnexus
---

# nimnexus

## Overview
The `nimnexus` toolset is designed for the initial processing stages of ChIP-nexus data. It addresses two critical needs in the workflow: preparing raw FASTQ files by managing complex barcode structures and de-duplicating aligned reads to ensure accurate peak calling. Use this skill to correctly configure trimming parameters for specific experimental barcodes and to efficiently clean up sorted BAM files.

## Command-Line Usage

### FASTQ Trimming and Filtering
The `trim` command processes raw reads by identifying random barcodes and experimental barcodes.

**Basic Pattern:**
```bash
zcat input.fastq.gz | nimnexus trim [options] <barcodes> | gzip -c > output.fastq.gz
```

**Key Arguments & Options:**
- `<barcodes>`: A comma-separated list of experimental barcodes (e.g., `CTGA,TGAC`). These follow the random barcode.
- `-r, --randombarcode <int>`: Length of the random barcode at the start of the read (default: 5).
- `-t, --trim <int>`: Number of bases to pre-trim before processing (default: 0).
- `-k, --keep <int>`: Minimum remaining read length required to keep the sequence (default: 18).

**Expert Tip:** For faster processing on systems with multiple cores, use `pigz` instead of standard `gzip`:
```bash
pigz -cd input.fastq.gz | nimnexus trim -t 1 CTGA,TGAC,GACT,ACTG | pigz -c > output.fastq.gz
```

### BAM De-duplication
The `dedup` command removes PCR duplicates. It requires a **sorted** BAM file as input.

**Basic Pattern:**
```bash
nimnexus dedup -t <threads> <input.sorted.bam> | samtools view -b > output.dedup.bam
```

**Critical Implementation Details:**
- **Output Format:** `nimnexus dedup` outputs in **SAM format** to stdout. You must pipe the output to `samtools view -b` to generate a compressed BAM file.
- **Threading:** Use the `-t` option to specify decompression threads for the input BAM file to improve performance.
- **Requirement:** The input BAM must be coordinate-sorted (e.g., via `samtools sort`) before running de-duplication.

## Best Practices
- **Barcode Validation:** Ensure the experimental barcodes provided to the `trim` command exactly match the sequences used in your library preparation.
- **Pipeline Integration:** Since `nimnexus` tools primarily use stdin/stdout, they are ideal for streaming pipelines to minimize disk I/O.
- **Memory Management:** While `nimnexus` is efficient, ensure your environment has `samtools` installed and available in the `$PATH` for the de-duplication step.

## Reference documentation
- [GitHub Repository - Avsecz/nimnexus](./references/github_com_Avsecz_nimnexus.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_nimnexus_overview.md)