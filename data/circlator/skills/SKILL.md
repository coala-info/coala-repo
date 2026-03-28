---
name: circlator
description: Circlator is a bioinformatics pipeline designed to circularize genome assemblies using corrected long reads. Use when user asks to circularize chromosomes or plasmids, reorient circular contigs to a specific start gene, or clean redundant sequences from an assembly.
homepage: https://github.com/sanger-pathogens/circlator
---

# circlator

## Overview
Circlator is a bioinformatics pipeline designed to finalize genome assemblies by circularizing chromosomes and plasmids. It works by taking an existing assembly (FASTA) and corrected long reads (FASTA/FASTQ). The tool maps reads to the ends of contigs, performs a local assembly of those ends, and merges the results back into the original assembly to create a seamless circular sequence. It also automates the "fixstart" process, ensuring that circularized contigs begin at a biologically relevant position, such as the *dnaA* gene.

## Core Workflow
The most efficient way to use Circlator is through the `all` command, which executes the entire pipeline (mapping, assembly, merging, cleaning, and reorienting).

### Basic Execution (PacBio)
For standard corrected PacBio reads:
```bash
circlator all assembly.fasta corrected_reads.fasta output_directory
```

### Handling Nanopore Data
Nanopore reads typically require more relaxed parameters due to different error profiles:
```bash
circlator all --merge_min_id 85 --merge_breaklen 1000 assembly.fasta reads.fasta output_directory
```

### Using Alternative Assemblers
By default, Circlator uses SPAdes for the internal assembly of contig ends. If SPAdes fails to produce a join, try Canu:
```bash
circlator all --assembler canu assembly.fasta reads.fasta output_directory
```

## Advanced CLI Patterns

### Customizing the Start Position
If you want the circularized genome to start at a specific gene or sequence (other than the default *dnaA*), provide a FASTA file containing your target sequences:
```bash
circlator all --genes_for_fixstart my_genes.fasta assembly.fasta reads.fasta output_dir
```

### Disabling Contig Merging
If you only want to circularize existing contigs and do not want Circlator to attempt joining different contigs together, use the `--no_pair_merge` flag:
```bash
circlator all --no_pair_merge assembly.fasta reads.fasta output_dir
```

### Running Individual Modules
For troubleshooting or specific tasks, you can run modules independently:
- **fixstart**: Reorient a circular FASTA file without running the whole pipeline.
  ```bash
  circlator fixstart input.fasta output_prefix
  ```
- **clean**: Remove small or redundant contigs that are completely contained within larger ones.
  ```bash
  circlator clean input.fasta output.fasta
  ```

## Expert Tips and Best Practices
- **Input Quality**: Circlator requires **corrected** long reads. Using raw, uncorrected reads will significantly decrease the success rate of circularization.
- **Assembly Fragmentation**: While Circlator can join contigs, it performs best on assemblies that are already relatively contiguous. If the assembly is highly fragmented, consider additional scaffolding before circularization.
- **Verification**: Always check the `outprefix.circularise.log` file. It provides a detailed breakdown of which contigs were circularized and the reasons why others were not (e.g., "no_match" or "small_overlap").
- **Final Output**: The definitive final assembly is always named `06.fixstart.fasta` within the output directory.
- **Post-Processing**: Circularization often leaves small indels at the join point. It is critical to run a polisher like Pilon (for Illumina) or Medaka/Nanopolish (for Nanopore) on the `06.fixstart.fasta` file to ensure high consensus accuracy at the junction.



## Subcommands

| Command | Description |
|---------|-------------|
| ariba test | Run Circlator on a small test dataset |
| circlator all | Run mapreads, bam2reads, assemble, merge, clean, fixstart |
| circlator bam2reads | Make reads from mapping to be reassembled |
| circlator clean | Clean contigs |
| circlator merge | Merge original and new assembly |
| circlator minimus2 | Runs minimus2 circularisation pipeline, see https://github.com/PacificBiosciences/Bioinformatics-Training/wiki/Circularising-and-trimming ... this script is a modified version of that protocol. It first runs minimus2 on the input contigs (unless --no_pre_merge is used). Then it tries to circularise each contig one at a time, by breaking it in the middle and using the two pieces as input to minimus2. If minimus2 outputs one contig, then that new one is assumed to be circularised and is kept, otherwise the original contig is kept. |
| circlator_assemble | Assemble reads using SPAdes/Canu |
| circlator_fixstart | Change start point of each sequence in assembly |
| circlator_get_dnaa | Downloads and filters a file of dnaA (or other) genes from uniprot |
| circlator_mapreads | Map reads using bwa mem |

## Reference documentation
- [Circlator Wiki Home](./references/github_com_sanger-pathogens_circlator_wiki.md)
- [Brief Instructions](./references/github_com_sanger-pathogens_circlator_wiki_Brief-instructions.md)
- [Task: all](./references/github_com_sanger-pathogens_circlator_wiki_Task_3A-all.md)
- [Troubleshooting Guide](./references/github_com_sanger-pathogens_circlator_wiki_Troubleshooting.md)