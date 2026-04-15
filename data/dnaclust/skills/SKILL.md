---
name: dnaclust
description: Analyzes DNA clustering data to identify patterns and relationships within DNA sequences. Use when user asks to filter clusters based on size, prepare clustered DNA data for further analysis, investigate homology, or convert clustered data into formats suitable for other bioinformatics tools.
homepage: https://github.com/jenhantao/DNACluster
metadata:
  docker_image: "biocontainers/dnaclust:v3-4b2-deb_cv1"
---

# dnaclust

Analyzes DNA clustering data to identify patterns and relationships within DNA sequences.
  Use this skill when you need to process DNA sequence clusters, such as:
  - Filtering clusters based on size (e.g., removing single sequences).
  - Preparing clustered DNA data for further analysis or primer design verification.
  - Investigating homology and potential cross-hybridization within oligonucleotide designs.
  - Converting clustered data into formats suitable for other bioinformatics tools.
body: |
  ## Overview
  The `dnaclust` tool is designed for analyzing DNA clustering data. It helps in processing and filtering clusters of DNA sequences, which is particularly useful for tasks like verifying primer designs by checking for homology among clustered oligonucleotides. The tool can also prepare clustered data into various output formats for downstream bioinformatics analyses.

  ## Usage Instructions

  The `dnaclust` tool operates on input files containing clustered DNA sequences. The primary function involves processing these clusters based on specified criteria.

  ### Basic Filtering and Output

  The core functionality revolves around filtering clusters and controlling the output format.

  **Key Options:**

  *   **Input File:** Specify the path to your DNA cluster file.
  *   **Output Directory:** Define a directory where processed files will be saved.
  *   **Filtering:** Options exist to remove clusters with a specific number of sequences (e.g., single sequences).

  **Example Command Structure:**

  ```bash
  dnaclust --input <input_cluster_file.txt> --output_dir <output_directory> [options]
  ```

  ### Advanced Options and Tips

  *   **Splitting Clusters:** The tool can split each cluster into its own file within the specified output directory. This is useful for examining individual clusters in detail.
  *   **Removing `#n` lines:** The tool can strip lines indicating the number of sequences in a cluster (e.g., `#2`, `#1`). This is often necessary for preparing data for other tools that expect a cleaner format.
  *   **Primer Design Verification:** When verifying primer designs, focus on clusters that contain multiple sequences. The tool's ability to filter out single-sequence clusters is crucial here. Analyze the output files for sequences within these multi-sequence clusters to identify potential cross-hybridization issues.
  *   **Format Conversion:** While not explicitly detailed in the provided documentation, the tool's ability to output in different formats suggests it can prepare data for tools like ClustalW. If you need a specific format, consult the tool's full documentation or experiment with its options.

  ### Example Scenario: Preparing for Primer Design Verification

  Imagine you have a file `oligos.dnaclust` containing clustered oligonucleotides designed by your software. You want to check for cross-hybridization among sequences that have clustered together.

  1.  **Filter out single sequences:** You are only interested in oligos that have at least one other oligo in their cluster.
  2.  **Split each cluster into a separate file:** This allows for easier inspection of each group of potentially cross-hybridizing oligos.
  3.  **Save results to a dedicated directory:** `~/dnaclust_output/`

  A command to achieve this might look like:

  ```bash
  dnaclust --input oligos.dnaclust --output_dir ~/dnaclust_output/ --strip-singletons --split-clusters
  ```
  *(Note: `--strip-singletons` and `--split-clusters` are hypothetical options based on the description of functionality. Actual option names may vary. Refer to the tool's help for exact parameters.)*

  ## Reference documentation
  - [DNACluster README](./references/github_com_jenhantao_DNACluster_blob_master_README.md)