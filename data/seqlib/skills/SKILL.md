---
name: seqlib
description: SeqLib is a C++ development library that provides a high-level interface for HTSlib, BWA-MEM, and Fermi engines to perform sequence alignment and assembly. Use when user asks to perform high-performance BAM I/O, align sequences in memory using BWA-MEM, or conduct de novo assembly with Fermi.
homepage: https://github.com/walaj/SeqLib
metadata:
  docker_image: "quay.io/biocontainers/seqlib:1.2.0--hbefcdb2_0"
---

# seqlib

## Overview
SeqLib is a specialized C++ development library that provides a high-level, memory-managed interface to the industry-standard HTSlib, BWA-MEM, and Fermi engines. It is designed to bridge the gap between low-level C bioinformatics libraries and modern C++ application development. By automating memory management through smart pointers and providing a unified API for alignment and assembly, SeqLib enables the creation of performant tools for sequence analysis, such as targeted re-aligners or variant callers, with significantly less boilerplate than raw HTSlib.

## Integration and Build Patterns

### Installation via Conda
The most efficient way to deploy the environment is through Bioconda:
```bash
conda install bioconda::seqlib
```

### Building from Source
When integrating SeqLib into a custom project, use the following CMake-based workflow:
```bash
git clone --recursive https://github.com/walaj/SeqLib.git
cd SeqLib && mkdir build && cd build
cmake ..
# If system htslib is missing, specify: -DHTSLIB_DIR=/path/to/htslib
make
```

### Compiler and Linker Configuration
To compile against SeqLib, you must include the base directory and the htslib subdirectory. Link against the static libraries in the following order:
- **Include Paths**: `$SEQ_DIR`, `$SEQ_DIR/htslib`
- **Linker Flags**: `libseqlib.a`, `libbwa.a`, `libfml.a`, `libhts.a`
- **External Dependencies**: If HTSlib was built with network support, you must append `-lcurl -lcrypto`.

## Core API Usage Patterns

### High-Performance BAM I/O
SeqLib offers 2-4x faster read/write speeds compared to BamTools. Use `BamReader` and `BamWriter` for stream processing:
- Use `SetWriteHeader` to clone headers from an existing index or reader.
- Use `GetNextRecord(BamRecord)` in a `while` loop for memory-efficient iteration.

### In-Memory BWA-MEM Alignment
Avoid writing intermediate FASTQ files by performing alignment directly in memory:
1. **Initialize**: Create a `BWAWrapper` object.
2. **Index**: Use `ConstructIndex(UnalignedSequenceVector)` for small, targeted regions or `LoadIndex("ref.fasta")` for whole genomes.
3. **Align**: Call `AlignSequence` to populate a `BamRecordVector` with results.

### Sequence Assembly with Fermi
For local de novo assembly (e.g., for structural variant breakpoint refinement):
1. Initialize `FermiAssembler`.
2. Add reads from a `BamRecordVector`.
3. Call `PerformAssembly()` to generate contigs.

### Genomic Interval Operations
Use `GenomicRegion` and `GenomicRegionCollection` for interval arithmetic. These classes utilize an internal interval tree for rapid overlap queries, making them ideal for filtering reads by specific loci or BED file regions.

## Expert Tips and Best Practices

- **Memory Safety**: SeqLib handles the `malloc` and `free` calls inherent in BWA and HTSlib. Do not manually manage memory for `BamRecord` or alignment objects; let the C++ destructors handle cleanup.
- **CRAM Support**: Unlike many older C++ APIs, SeqLib natively supports the CRAM format. Ensure your `BamWriter` is initialized with `SeqLib::CRAM` if storage efficiency is a priority.
- **Secondary Alignments**: When using `AlignSequence`, you can tune the `secondary_cutoff` (e.g., 0.9) and `secondary_cap` to control the sensitivity of multi-mapping read reporting.
- **Thread Safety**: While SeqLib is fast, be aware that underlying HTSlib operations may require explicit thread pool management if you are parallelizing I/O across multiple cores.

## Reference documentation
- [SeqLib GitHub Repository](./references/github_com_walaj_SeqLib.md)
- [Bioconda SeqLib Overview](./references/anaconda_org_channels_bioconda_packages_seqlib_overview.md)