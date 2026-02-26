---
name: novobreak
description: novoBreak identifies structural variant breakpoints in cancer genomes using local assembly of k-mers. Use when user asks to detect deletions, duplications, inversions, translocations, or viral integrations in genomic data.
homepage: https://github.com/czc/nb_distribution
---


# novobreak

## Overview
novoBreak is a specialized tool for identifying structural variant breakpoints in cancer genomes. Unlike tools that rely solely on discordant read pairs or split-read mapping, novoBreak utilizes local assembly to reconstruct the genomic architecture at the breakpoint. This approach provides high-resolution detection for Deletions (DEL), Duplications (DUP), Inversions (INV), and Translocations (TRA). It is optimized for x86_64 Linux environments and requires significant physical memory (approx. 40GB).

## Command Line Usage

### Standard Workflow
The most efficient way to run novoBreak is using the provided shell wrapper, which handles the multi-step process of k-mer analysis, local assembly, and SV calling.

```bash
bash run_novoBreak.sh <novoBreak_exe_dir> <ref.fasta> <tumor.bam> <normal.bam> <threads> [output_dir]
```

### Direct Binary Execution
For granular control over k-mer extraction, use the binary directly:

```bash
novoBreak -i <tumor.bam> -c <normal.bam> -r <ref.fasta> -o <output.kmer> [options]
```

**Key Options:**
- `-k <int>`: K-mer size (default 31, max 31).
- `-m <int>`: Minimum k-mer count to be considered a "novo" k-mer (default 3).
- `-g <int>`: Set to 1 to output germline events (default 0, somatic only).

## Expert Tips and Best Practices

### Virus Integration Analysis
To detect viral integrations (e.g., HPV, HBV):
1. Append the virus genome sequences to your human reference FASTA.
2. Realign your reads to this combined reference.
3. Run novoBreak; viral integrations will typically be reported as Translocation (TRA) events between the human and viral contigs.

### Filtering and Quality Control
The primary output is `novoBreak.pass.flt.vcf`. If you need to perform custom filtering:
- **Reliability Score**: Check Column 6 (QUAL) in the VCF. Higher values indicate more reliable events.
- **VCF Extensions**: Columns 11 through 39 in the intermediate `*.sp.vcf` files contain rich metadata, including:
    - `tumor_bkpt_sp_reads`: Number of split reads in the tumor.
    - `tumor_bkpt_discordant_reads`: Number of discordant read pairs.
    - `contig_size`: The size of the assembled contig supporting the SV.
- **False Positives**: Many inferred SVs can be false positives due to repetitive regions. Use the `filter_sv2.pl` script included in the distribution for an alternative, more stringent filtering approach.

### Resource Management
- **Memory**: Ensure the system has at least 40GB of RAM.
- **Storage**: novoBreak generates several intermediate files during assembly. While these are useful for debugging, they can be large; delete them after verifying the final VCF if space is limited.
- **Dependencies**: Ensure `SSAKE`, `bwa`, and `samtools` (v1.3+) are in your PATH.

## Reference documentation
- [novoBreak README](./references/github_com_czc_nb_distribution_blob_master_README.md)
- [Bioconda novobreak Overview](./references/anaconda_org_channels_bioconda_packages_novobreak_overview.md)