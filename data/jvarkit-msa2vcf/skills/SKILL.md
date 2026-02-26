---
name: jvarkit-msa2vcf
description: This tool converts multiple sequence alignments into variant call format files by treating each sequence as a sample relative to a reference. Use when user asks to convert FASTA or CLUSTALW alignments to VCF, identify variants from a consensus sequence, or generate gVCF-style output including invariant sites.
homepage: https://lindenb.github.io/jvarkit/MsaToVcf.html
---


# jvarkit-msa2vcf

## Overview
The `jvarkit-msa2vcf` tool is a specialized utility for transforming sequence alignments into variant call format (VCF). It treats each sequence in the alignment as a sample and identifies differences relative to a reference (either the first sequence or a user-defined consensus). This is particularly useful for small-scale comparative genomics, viral/bacterial strain analysis, and converting phylogenetic alignment data into a format compatible with downstream variant analysis tools.

## Usage Patterns

### Basic Conversion
To convert a CLUSTALW (`.aln`) or FASTA alignment to VCF using the first sequence as the reference:
```bash
java -jar dist/jvarkit.jar msa2vcf input.aln > output.vcf
```

### Defining a Reference and Contig Name
By default, the tool uses `chrUn` as the chromosome name. You can specify a custom name and choose a specific sequence from the alignment to act as the reference/consensus:
```bash
java -jar dist/jvarkit.jar msa2vcf --reference_contig_name "Chromosome_1" --consensus "Sequence_ID_A" input.fasta > output.vcf
```

### Handling Low-Quality or Ambiguous Bases
If your alignment contains many `N` bases that should not be treated as variants, use the `--ignore-n-bases` flag:
```bash
java -jar dist/jvarkit.jar msa2vcf -N input.aln > output.vcf
```

### Outputting All Sites
To generate a genomic VCF (gVCF) style output that includes invariant sites (useful for calculating total depth or site-specific statistics):
```bash
java -jar dist/jvarkit.jar msa2vcf --allsites input.aln > output.vcf
```

## Expert Tips
- **Haploid vs Diploid**: For microbial or mitochondrial data, use the `--haploid` flag to ensure genotype calls (GT) are formatted correctly for haploid organisms (e.g., `1` instead of `1/1`).
- **Piping**: The tool accepts input from stdin, making it easy to integrate with alignment tools:
  ```bash
  clustalw -infile=seqs.fasta -outfile=stdout | java -jar dist/jvarkit.jar msa2vcf
  ```
- **Deprecation Note**: While `msa2vcf` is robust for many use cases, the author suggests `snp-sites` as a modern alternative for very large datasets. Use `msa2vcf` specifically when you require the specific VCF header metadata or the `--consensus` selection logic provided by jvarkit.
- **Memory Management**: For large alignments, ensure the JVM has enough memory by using the `-Xmx` flag (e.g., `java -Xmx2g -jar ...`).

## Reference documentation
- [MsaToVcf Documentation](./references/lindenb_github_io_jvarkit_MsaToVcf.html.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_jvarkit-msa2vcf_overview.md)