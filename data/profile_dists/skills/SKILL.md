---
name: profile_dists
description: Calculates genetic distances between allelic profiles and supports querying genetically similar samples. Use when user asks to compare genetic similarity of samples, identify genetically close samples, generate distance matrices, or perform rapid querying of sample databases for genetic similarity.
homepage: https://pypi.org/project/profile-dists
---


# profile_dists

Calculates genetic distances between allelic profiles and supports querying
  genetically similar samples within a defined threshold. Use when needing to:
  - Compare genetic similarity of biological samples based on their allelic profiles.
  - Identify samples that are genetically close to a reference set.
  - Generate distance matrices for clustering or phylogenetic analysis.
  - Perform rapid querying of large sample databases for genetic similarity.
body: |
  ## Overview
  The `profile_dists` tool is designed for efficiently calculating genetic distances between samples based on their allelic profiles. It's particularly useful for comparative genomics, outbreak surveillance, and population genetics studies where understanding the genetic similarity between samples is crucial. The tool can generate pairwise distance matrices and also supports fast querying against a reference database to find similar samples within a specified distance threshold. It handles various input formats and offers flexibility in output formats and distance calculation methods.

  ## Usage

  The `profile_dists` command-line tool offers several functionalities for calculating genetic distances and querying sample profiles.

  ### Core Functionality: Distance Matrix Calculation

  To construct a pairwise distance matrix between a query set and a reference set of allelic profiles:

  ```bash
  profile_dists --query <query_profiles.profile> --ref <reference_profiles.profile> --outdir <results_directory>
  ```

  For clustering analysis, you can create a symmetric/square distance matrix by providing the same file for both `--query` and `--ref`:

  ```bash
  profile_dists --query <samples.profile> --ref <samples.profile> --outdir <results_directory>
  ```

  ### Fast Matching and Querying

  To query a set of sample profiles against a reference database and report matches:

  ```bash
  profile_dists --query <queries.profile> --ref <reference.profile> --outdir <results_directory> --match_threshold <distance_threshold>
  ```

  The `--match_threshold` parameter is used to define the maximum distance for a match. The output can be a matrix or a three-column table `[query_id, reference_id, dist]`.

  ### Key Command-Line Parameters

  *   `--query` or `-q`: Path to the query allelic profiles file.
  *   `--ref` or `-r`: Path to the reference allelic profiles file.
  *   `--outdir` or `-o`: Directory to save the output files.
  *   `--outfmt` or `-u`: Output format. Options: `matrix` (default), `pairwise`.
  *   `--file_type` or `-e`: Output file type. Options: `text` (default), `parquet`.
  *   `--distm` or `-d`: Distance method. Options: `hamming` (raw Hamming distance), `scaled` (default).
  *   `--missing_thresh` or `-t`: Maximum percentage of missing data allowed per locus (0 to 1).
  *   `--sample_qual_thresh` or `-c`: Maximum percentage of missing data allowed per sample (0 to 1).
  *   `--match_threshold` or `-a`: Threshold for matching (used with `pairwise` format).
  *   `--force` or `-f`: Overwrite existing output directory.
  *   `--skip` or `-s`: Skip QA/QC steps.
  *   `--columns` or `-c`: Specify columns to keep (comma-separated or one per line).
  *   `--count_missing` or `-n`: Count missing data as differences.
  *   `--cpus` or `-p`: Number of CPUs to use (default: 1).

  ### Input Data Formats

  `profile_dists` supports several input formats, including a native format and a format compatible with chewBBACA. Missing data can be represented by `?`, `0`, `-`, `None`, or a space. Non-integer fields in chewBBACA format are treated as missing data.

  **Native Format Example:**
  ```
  Native id locus_1 locus_2 locus_3
  S1 1 1 1
  S2 1 1 2
  S3 1 2 ?
  ```

  **chewBBACA Format Example:**
  ```
  chewBBACA id locus_1 locus_2 locus_3
  S1 1 INF-2 1
  S2 1 1 NIPH
  ```

  ### Expert Tips

  *   **Output Format**: For large datasets, consider using `--file_type parquet` for more efficient storage and retrieval.
  *   **Distance Method**: The `scaled` distance method is generally recommended for its robustness.
  *   **Missing Data**: Carefully consider the `--missing_thresh` and `--sample_qual_thresh` parameters to control how missing data affects distance calculations.
  *   **Performance**: For multi-core systems, utilize the `--cpus` parameter to speed up calculations.
  *   **Overwriting**: Use `--force` or `-f` cautiously when you intend to overwrite existing output directories.

  ## Reference documentation
  - [profile_dists GitHub Repository](https://github.com/phac-nml/profile_dists.md)
  - [profile_dists Overview on Anaconda.org](https://anaconda.org/bioconda/profile_dists)