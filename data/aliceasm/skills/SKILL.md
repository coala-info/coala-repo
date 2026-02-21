name: aliceasm
description: Efficient HiFi genome and metagenome assembler producing haplotype-separated assemblies. Use when you have high-accuracy long reads (HiFi, <0.1% error) and need a fast, memory-efficient assembly for either single organisms or complex metagenomic samples. It is particularly effective for resolving haplotypes and strains.

# aliceasm

Alice is a genomic and metagenomic assembler designed specifically for HiFi reads. It uses Mapping-friendly Sequence Reduction (MSR) to shrink reads, perform assembly on the reduced data, and then inflate the assembly back to normal size.

## Core Usage

The basic command requires an input file and an output directory:

```bash
aliceasm -r reads.fastq -o output_directory -t 8
```

### Primary Outputs
- `assembly.fasta`: The assembled contigs.
- `assembly.gfa`: The assembly graph (identical contigs to the fasta).

## Workflow Configurations

### Single Genome Assembly
When assembling a single organism, you must use specific flags to simplify the output graph and improve contiguity.
- **Flag**: `--single-genome`
- **Abundance**: Set `-m` to approximately `expected_coverage / 2`.

```bash
# Example for a single genome with 40x coverage
aliceasm -r reads.fq.gz -o assembly_out --single-genome -m 20 -t 16
```

### Metagenome Assembly
For metagenomic samples, use the default settings which are optimized for strain resolution and varying abundances.
- **Default `-m`**: 5 (minimum k-mer abundance to consider "solid").

## Parameter Tuning

| Option | Description | Best Practice |
| :--- | :--- | :--- |
| `-l, --order` | MSR compression order | Must be odd. Default 101. Higher values increase context. |
| `-c, --compression` | Compression factor | Default 20. Higher values speed up assembly but may lose sensitivity. |
| `-k, --kmer-sizes` | K-mer sizes for assembly | Default `17,31`. Must include at least 31. |
| `-H, --no-hpc` | Disable homopolymer compression | Use only if your reads are already processed or if HPC is not desired. |

## Expert Tips

1. **Memory Efficiency**: Alice is extremely memory-efficient (e.g., ~0.33GB RAM for an E. coli genome). It is suitable for large datasets on standard workstations.
2. **Dependencies**: Alice requires `bcalm` to be in your PATH. If it is installed in a non-standard location, use `--bcalm /path/to/bcalm`.
3. **Input Quality**: Alice is optimized for <0.1% error rates. Using it on noisier ONT reads (non-Duplex/non-Q20) is not recommended as the MSR process increases the effective error rate.
4. **Cleanup**: Use the `--clean` flag to automatically remove the `tmp` folder after a successful run to save disk space.