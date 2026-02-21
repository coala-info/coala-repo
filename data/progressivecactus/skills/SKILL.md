---
name: progressivecactus
description: Progressive Cactus is a high-performance genome alignment package that uses a phylogenetic tree to guide the alignment of multiple genomes.
homepage: https://github.com/glennhickey/progressiveCactus
---

# progressivecactus

## Overview
Progressive Cactus is a high-performance genome alignment package that uses a phylogenetic tree to guide the alignment of multiple genomes. By iteratively aligning sibling genomes to estimate ancestral sequences, it builds a comprehensive hierarchical alignment. This skill helps users manage the complex setup requirements, format input sequence files correctly, and execute the alignment pipeline efficiently on large datasets.

## Environment Management
Progressive Cactus relies on a specific virtual environment to manage its dependencies and submodules.

- **Loading the environment**: Before using any tools (except the main aligner script), you must load the environment to set the correct `PATH` and `PYTHONPATH`.
  ```bash
  source environment
  ```
- **Rebuilding**: If you need to run `make` again, you must first exit the environment.
  ```bash
  deactivate
  ```
- **Path Restrictions**: Do not install Progressive Cactus in a path containing spaces. If your path has spaces, use a symbolic link as a workaround:
  ```bash
  ln -s "path with spaces" "install_path_no_spaces"
  ```

## The Sequence File (seqFile)
The `seqFile` is the primary input configuration. It defines the phylogeny and the location of the FASTA files.

### Structure
1. **Newick Tree (Optional)**: A single line containing the phylogenetic tree. All leaves must be labeled and unique.
2. **Genome Mapping**: Lines following the tree mapping labels to file paths.
   - Format: `name path`
   - Paths must be absolute.
   - Paths can point to a single FASTA or a directory of FASTAs.

### Reference Quality Flag
Use an asterisk (`*`) before a genome name to mark it as "reference quality." This allows the aligner to use that genome as an outgroup for sub-alignments.
```text
(((human:0.006,chimp:0.006):0.002,gorilla:0.008):0.009,orang:0.018);
*human /data/genomes/human/human.fa
*chimp /data/genomes/chimp/
*gorilla /data/genomes/gorilla/gorilla.fa
orang /data/genomes/orang/
```

## Running the Aligner
The main entry point is the `runProgressiveCactus.sh` script.

### Basic Command
```bash
bin/runProgressiveCactus.sh <seqFile> <workDir> <outputHalFile>
```

### Key Arguments and Options
- **workDir**: The directory where intermediate files are stored. If a run is interrupted, Progressive Cactus will automatically resume by checking this directory.
- **outputHalFile**: The final alignment in HAL (Hierarchical ALignment) format.
- **--overwrite**: Use this flag to ignore existing progress in the `workDir` and start the alignment from scratch.

## Expert Tips and Best Practices
- **Memory Requirements**: Aligning mammal-sized genomes typically requires at least one machine with 150GB+ of RAM.
- **FASTA Headers**: Ensure the first word of every FASTA header is unique within its genome. Headers should be alphanumeric to ensure compatibility with downstream visualization tools like the UCSC Genome Browser.
- **Cluster Support**: For large-scale alignments, ensure the `workDir` is located on a filesystem accessible by all nodes in your cluster (e.g., SGE or Parasol).
- **HAL Tools**: Once the alignment is complete, use the tools in the `submodules/` directory (after sourcing the environment) to process the `.hal` file, such as `hal2maf` for conversion.
- **Maintenance Note**: While this version is functional, the project has transitioned to a newer version maintained by the Comparative Genomics Toolkit which uses Toil for improved cloud computing support.

## Reference documentation
- [Progressive Cactus Manual](./references/github_com_glennhickey_progressiveCactus.md)