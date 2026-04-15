---
name: gustaf
description: Gustaf performs multi-split mapping of sequencing reads. Use when user asks to map reads to a reference genome, especially for complex genomic rearrangements or structural variations.
homepage: https://github.com/seqan/seqan/tree/master/apps/gustaf/README.rst
metadata:
  docker_image: "quay.io/biocontainers/gustaf:1.0.10--h8ecad89_1"
---

# gustaf

yaml
name: gustaf
description: |
  A tool for multi-split mapping of sequencing reads. Use when you need to perform advanced read mapping, particularly for scenarios involving complex genomic rearrangements or structural variations where standard mapping tools may struggle. This skill is suitable for tasks requiring the alignment of reads that might span multiple distinct genomic locations.
```
## Overview
Gustaf is a specialized bioinformatics tool designed for the intricate task of multi-split mapping of sequencing reads. This means it can handle reads that don't map to a single contiguous location in the genome, which is crucial for identifying complex genomic rearrangements, structural variations, or reads that span across repetitive regions. Use Gustaf when standard mapping tools are insufficient for your analysis due to the complexity of the genomic data or the nature of the variations you are trying to detect.

## Usage Instructions

Gustaf is a command-line tool. The primary function involves providing input sequences and a reference genome to perform multi-split mapping.

### Basic Mapping

The core functionality of Gustaf is to map reads to a reference genome.

```bash
gustaf map -r <reference_genome.fa> -q <reads.fq> -o <output_alignment.sam>
```

*   `-r <reference_genome.fa>`: Path to the reference genome file in FASTA format.
*   `-q <reads.fq>`: Path to the input sequencing reads file (FASTQ format).
*   `-o <output_alignment.sam>`: Path for the output alignment file in SAM format.

### Multi-Split Mapping Options

Gustaf's strength lies in its multi-split mapping capabilities. While the basic `map` command will attempt this, specific parameters can fine-tune this behavior.

*   **Maximum Splits**: Control the maximum number of splits a read can be divided into.
    ```bash
    gustaf map -r <reference_genome.fa> -q <reads.fq> -o <output.sam> --max-splits <N>
    ```
    Replace `<N>` with an integer representing the maximum number of allowed splits.

*   **Minimum Split Length**: Define the minimum length for each segment of a split read.
    ```bash
    gustaf map -r <reference_genome.fa> -q <reads.fq> -o <output.sam> --min-split-length <L>
    ```
    Replace `<L>` with an integer representing the minimum length in bases.

### Output Formats

Gustaf supports various output formats for alignments. SAM is the default, but BAM is often preferred for its compressed size.

*   **BAM Output**:
    ```bash
    gustaf map -r <reference_genome.fa> -q <reads.fq> -o <output_alignment.bam> --output-format bam
    ```

### Advanced Parameters and Tips

*   **Threads**: Utilize multiple threads for faster processing.
    ```bash
    gustaf map -r <reference_genome.fa> -q <reads.fq> -o <output.sam> -t <num_threads>
    ```
    Replace `<num_threads>` with the desired number of CPU threads.

*   **Paired-End Reads**: Gustaf can handle paired-end reads. Ensure your input FASTQ file is correctly formatted or provide two files if necessary (though the documentation implies a single file for reads). The tool is designed to infer pairing from the read IDs.

*   **Reference Indexing**: For optimal performance, ensure your reference genome is indexed. Gustaf, like many aligners, will likely require an index (e.g., a `.fai` file for FASTA). If not present, Gustaf might generate one, or you may need to pre-index it using a tool like `samtools faidx`.

*   **Error Handling**: Pay close attention to the output messages. Gustaf's multi-split mapping can be computationally intensive, and errors might relate to memory, disk space, or invalid input files.

## Reference documentation
- [README for Gustaf](./references/github_com_seqan_seqan_blob_main_apps_gustaf_README.rst.md)