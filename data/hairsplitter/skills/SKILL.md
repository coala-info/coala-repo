---
name: hairsplitter
description: Hairsplitter is a specialized tool designed to "un-collapse" genomic regions where an assembler has merged distinct but similar sequences—such as alleles, repeats, or strain-specific variants—into a single contig.
homepage: https://github.com/RolandFaure/HairSplitter
---

# hairsplitter

## Overview
Hairsplitter is a specialized tool designed to "un-collapse" genomic regions where an assembler has merged distinct but similar sequences—such as alleles, repeats, or strain-specific variants—into a single contig. By analyzing the underlying long-read data, it identifies subtle variations to partition reads and reconstruct the individual versions of the sequence. It is largely parameter-free and can automatically infer the appropriate ploidy for each contig.

## Usage Patterns

### Basic Execution
The most common use case involves providing a draft assembly and the long reads used to generate it.

```bash
python hairsplitter.py -i assembly.gfa -f reads.fastq -x ont -o output_dir/
```

### Use Case Selection (`-x`)
Always specify the sequencing technology to ensure the tool uses appropriate internal parameters:
- `ont`: Oxford Nanopore reads (default).
- `hifi`: PacBio HiFi reads.
- `pacbio`: Standard PacBio CLR reads.
- `amplicon`: For amplicon sequencing data.

### Polishing Options
Hairsplitter uses a polisher to finalize the split contigs.
- **Racon (Default):** Fast and generally sufficient for most applications.
- **Medaka:** Use `-p medaka` for higher consensus accuracy with ONT reads, though it is significantly slower.
- **Polish Everything:** Use `-P` to force polishing on all contigs, including those that were not split.

### Metagenomic Refinement
When working with metagenomes to recover lost strains:
- Use `--rarest-strain-abundance` (default 0.01) to set the sensitivity for detecting low-abundance strains.
- If you know the expected coverage of a single haplotype, provide it with `-c <int>` to improve splitting logic.

### Performance and Resource Management
- **Threads:** Use `-t` to specify CPU cores.
- **Memory:** For large datasets or memory-constrained environments, enable `-l` (low-memory mode).
- **Cleanup:** By default, the tool keeps many intermediate files. Use `--no_clean` only if you need to debug specific modules.

## Best Practices
- **Input Formats:** The tool accepts both FASTA and GFA for the assembly. GFA is often preferred as it may contain additional connectivity information.
- **Structural Errors:** If the input assembly is known to have misassemblies, use `--correct-assembly`. Note that this significantly increases runtime.
- **SNP Rescue:** If the tool is missing known variants, adjust `-u` (default 0.33). This parameter controls the proportion of reads that must share a SNP for it to be considered "true."
- **Resuming:** If a run is interrupted, use the `--resume` flag to continue from the last successful module.

## Reference documentation
- [Hairsplitter GitHub Repository](./references/github_com_RolandFaure_Hairsplitter.md)