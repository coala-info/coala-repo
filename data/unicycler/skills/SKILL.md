---
name: unicycler
description: Unicycler assembles bacterial genomes, producing complete and circularized sequences. Use when user asks to assemble bacterial genomes, perform hybrid assembly, perform Illumina-only assembly, perform long-read-only assembly, or resolve plasmids.
homepage: https://github.com/rrwick/Unicycler
metadata:
  docker_image: "quay.io/biocontainers/unicycler:0.5.1--py312hdcc493e_5"
---

# unicycler

## Overview
Unicycler is a specialized assembly pipeline optimized for bacterial genomes. It functions as a "short-read-first" hybrid assembler, meaning it primarily builds an assembly graph from high-accuracy Illumina reads and then uses long reads to resolve the paths through that graph. It can also operate in Illumina-only mode (acting as a SPAdes optimizer) or long-read-only mode (using a miniasm plus Racon pipeline). Its primary strength is its ability to produce complete, circularized assemblies with very low misassembly rates without requiring manual intervention or separate circularization tools.

## Common CLI Patterns

### Hybrid Assembly (Recommended)
The most effective use of Unicycler is combining paired-end Illumina reads with any amount of long reads.
```bash
unicycler -1 reads_R1.fastq.gz -2 reads_R2.fastq.gz -l long_reads.fastq.gz -o output_dir
```

### Illumina-only Assembly
Produces a cleaner assembly graph than SPAdes alone by performing additional polishing and small contig removal.
```bash
unicycler -1 reads_R1.fastq.gz -2 reads_R2.fastq.gz -o output_dir
```

### Long-read-only Assembly
Useful when Illumina reads are unavailable. It uses a miniasm and Racon-based pipeline.
```bash
unicycler -l long_reads.fastq.gz -o output_dir
```

### Performance and Resource Management
Use the `--threads` flag to speed up the assembly process, particularly during the SPAdes and polishing steps.
```bash
unicycler -1 R1.fastq.gz -2 R2.fastq.gz -l long.fastq.gz -o output_dir --threads 16
```

## Expert Tips and Best Practices

### Selecting the Assembly Mode
Unicycler offers three modes via the `--mode` flag that trade off between contiguity and accuracy:
*   **conservative**: Minimizes misassemblies; may result in more fragments.
*   **normal** (default): A balance between contiguity and accuracy.
*   **bold**: Maximizes contiguity; higher risk of misassemblies or merging distinct genomic regions.

### Handling Plasmids
Unicycler is excellent at resolving plasmids. If you suspect small, high-copy plasmids are missing, check the `assembly.gfa` file in **Bandage**. Unicycler often identifies these as small circular components that might be filtered out if their depth is significantly different from the chromosome.

### Depth and Quality Requirements
*   **Hybrid Mode**: Even low-depth long reads (e.g., 10x-20x) can be sufficient to complete a genome if the Illumina graph is high quality.
*   **Long-read-only**: Requires higher depth (typically >50x) and may benefit from modern high-accuracy long reads (HiFi/Q20+).
*   **Note**: If you have very high-depth, high-accuracy long reads (>100x), consider using a "long-read-first" approach (like Trycycler) instead of Unicycler.

### Output Files to Monitor
*   `assembly.fasta`: The final assembled contigs.
*   `assembly.gfa`: The assembly graph. Always visualize this in Bandage to confirm circularization (look for closed loops).
*   `unicycler.log`: Detailed record of the assembly process, including k-mer selection and bridging decisions.

### Troubleshooting Circularization
If a replicon (like the chromosome) fails to circularize:
1.  Check the log for "Could not separate the graph into components."
2.  Ensure you have sufficient long-read length; if the repeats in the genome are longer than your longest reads, Unicycler cannot bridge them.
3.  Try the `--mode bold` setting if the assembly is nearly complete but has a few stubborn gaps.

## Reference documentation
- [Unicycler Main README](./references/github_com_rrwick_Unicycler.md)
- [Unicycler Wiki and Tips](./references/github_com_rrwick_Unicycler_wiki.md)
- [Bioconda Unicycler Overview](./references/anaconda_org_channels_bioconda_packages_unicycler_overview.md)