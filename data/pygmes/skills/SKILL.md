---
name: pygmes
description: pygmes is a Python wrapper for GeneMark-ES that simplifies gene prediction on fragmented and incomplete genomes. Use when user asks to predict genes in genomic or metagenomic data.
homepage: https://github.com/openpaul/pygmes
metadata:
  docker_image: "quay.io/biocontainers/pygmes:0.1.7--py_0"
---

# pygmes

A Python wrapper for GeneMark-ES, designed to improve its usability for fragmented and incomplete genomes, particularly in metagenomic analysis.
  Use this skill when you need to run GeneMark-ES for gene prediction on genomic or metagenomic data, especially when dealing with challenging or incomplete sequences.
  This skill is suitable for tasks that require gene prediction in microbial or eukaryotic genomes.
body: |
  ## Overview
  The `pygmes` tool is a Python wrapper that simplifies the execution of GeneMark-ES, a popular software for predicting genes in DNA sequences. It is particularly useful for handling fragmented and incomplete genomes, which are common in metagenomic studies. `pygmes` aims to make GeneMark-ES more accessible and efficient for these types of analyses.

  ## Usage Instructions

  `pygmes` is primarily used as a command-line tool. The core functionality involves providing input sequences and specifying parameters for GeneMark-ES.

  ### Basic Gene Prediction

  To perform gene prediction on a FASTA file:

  ```bash
  pygmes <input.fasta>
  ```

  This command will run GeneMark-ES with default settings on the provided FASTA file. The output will typically include predicted gene locations and sequences.

  ### Specifying Output Files

  You can control the output file names using the following options:

  *   `-o <output_prefix>`: Specifies a prefix for all output files. For example, `-o my_analysis` will create files like `my_analysis.faa`, `my_analysis.ffn`, etc.

  ### Handling Metagenomic Data

  For metagenomic analysis, `pygmes` can be used with specific modes:

  *   `--meta`: Enables metagenomic mode, which is optimized for fragmented genomes.

  ```bash
  pygmes --meta <input.fasta> -o metagenome_results
  ```

  ### Advanced Options and Parameters

  `pygmes` allows passing various parameters directly to GeneMark-ES. Consult the GeneMark-ES documentation for a comprehensive list of parameters. Some common parameters that might be relevant and can be passed through `pygmes` include:

  *   `--euk`: Use this flag for eukaryotic genomes.
  *   `--prok`: Use this flag for prokaryotic genomes.
  *   `--model <model_name>`: Specify a particular GeneMark-ES model to use.

  Example for eukaryotic gene prediction:

  ```bash
  pygmes --euk <eukaryotic_genome.fasta> -o euk_genes
  ```

  ### Pretrained Models

  `pygmes` utilizes pretrained models for GeneMark-ES. The tool is designed to work with these models out-of-the-box.

  ### Installation and Dependencies

  `pygmes` can be installed via conda:

  ```bash
  conda install bioconda::pygmes
  ```

  Ensure that GeneMark-ES and its dependencies are correctly installed and accessible in your environment.

  ## Expert Tips

  *   **Fragmented Genomes**: Always use the `--meta` flag when analyzing metagenomic data or genomes known to be fragmented. This is the primary advantage of `pygmes`.
  *   **Eukaryotic vs. Prokaryotic**: Explicitly specify `--euk` or `--prok` based on your input data to ensure the correct GeneMark-ES models are utilized.
  *   **Output Prefix**: Use the `-o` flag consistently to manage your output files, especially when running multiple analyses.
  *   **Error Handling**: If GeneMark-ES fails, `pygmes` may attempt to use Prodigal as a fallback (as indicated in commit history). Monitor output for any fallback mechanisms or errors.
  *   **Archived Repository**: Be aware that the `openpaul/pygmes` repository has been archived. While the tool may still function, future development or support might be limited.

  ## Reference documentation
  - [README.md](./references/github_com_openpaul_pygmes.md)