---
name: unicycler-data
description: Unicycler is a specialized hybrid assembler for bacterial genomes that uses short reads for accuracy and long reads to resolve repeats and circularize replicons. Use when user asks to assemble bacterial genomes, perform hybrid assembly, conduct Illumina-only assembly, perform long-read-only assembly, or circularize replicons.
homepage: https://github.com/rrwick/Unicycler
---


# unicycler-data

## Overview
Unicycler is a specialized assembly pipeline designed specifically for bacterial genomes. It functions as a "short-read-first" hybrid assembler, meaning it primarily uses Illumina reads to build a high-accuracy assembly graph and then uses long reads (Nanopore or PacBio) to resolve repeats and bridge gaps. It is highly regarded for its ability to automatically circularize replicons (chromosomes and plasmids) and produce clean, assembly-ready graphs compatible with Bandage.

## Command Line Usage Patterns

### 1. Hybrid Assembly (Recommended)
The most powerful use case for Unicycler, providing the accuracy of short reads with the structural resolution of long reads.
```bash
unicycler -1 short_reads_R1.fastq.gz -2 short_reads_R2.fastq.gz -l long_reads.fastq.gz -o output_directory
```

### 2. Illumina-only Assembly
Functions as a SPAdes optimizer, running SPAdes across multiple k-mer sizes and selecting the best result.
```bash
unicycler -1 short_reads_R1.fastq.gz -2 short_reads_R2.fastq.gz -o output_directory
```

### 3. Long-read-only Assembly
Uses a miniasm plus Racon pipeline. Note that for high-depth, high-accuracy long reads, the author often recommends other tools (like Trycycler), but Unicycler remains effective for quick assemblies.
```bash
unicycler -l long_reads.fastq.gz -o output_directory
```

## Expert Tips and Best Practices

### Assembly Modes
Unicycler offers three modes that control the trade-off between assembly "cleanliness" and "completeness":
*   **--mode conservative**: Lowest risk of misassembly. Produces more fragmented assemblies but ensures high accuracy.
*   **--mode normal (default)**: A balance between accuracy and contiguity.
*   **--mode bold**: Most aggressive at bridging gaps. Use this if you have low long-read depth and want to attempt a complete genome, but be aware of a higher misassembly risk.

### Circularization and Rotation
*   Unicycler automatically attempts to circularize replicons. It uses BLAST+ to find overlaps at the ends of contigs.
*   It will rotate circular contigs so they start at a specific gene (like *dnaA* or *repA*) if a suitable starting point is found, making comparative genomics easier.

### Handling Plasmids
*   Unicycler is excellent at recovering small, multicopy plasmids that other assemblers might filter out as "noise."
*   If you have "tangled" small plasmids in your graph, check the `assembly.gfa` file in Bandage to manually resolve overlaps.

### Key Constraints
*   **Isolates Only**: Do not use Unicycler for metagenomes or eukaryotic genomes. It assumes a bacterial isolate with relatively uniform coverage.
*   **Dependencies**: Ensure `spades.py`, `racon`, and `makeblastdb`/`tblastn` (from BLAST+) are in your PATH. You can specify paths manually using `--spades_path`, `--racon_path`, etc.
*   **Read Depth**: While Unicycler can work with as little as 5x-10x long-read depth in hybrid mode, 20x or more is generally required for consistent genome completion.

### Output Files
*   `assembly.fasta`: The final assembled contigs.
*   `assembly.gfa`: The assembly graph. **Always inspect this in Bandage** to verify circularity and resolve any ambiguities.
*   `unicycler.log`: Detailed log of the assembly process, including k-mer selection and bridging decisions.

## Reference documentation
- [Unicycler Main Documentation](./references/github_com_rrwick_Unicycler.md)
- [Unicycler Wiki and Tips](./references/github_com_rrwick_Unicycler_wiki.md)