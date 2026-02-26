---
name: jpredapi
description: "This tool submits protein sequences to the JPRED server for secondary structure prediction and retrieves the results. Use when user asks to predict protein secondary structure."
homepage: https://github.com/MoseleyBioinformaticsLab/jpredapi
---


# jpredapi

Submits protein sequences to the JPRED server for secondary structure prediction and retrieves the results.
  Use when you need to predict the secondary structure of a protein sequence using the JPRED web server.
  This skill is suitable for both programmatic access via its Python library and command-line interface.
body: |
  ## Overview
  The `jpredapi` tool provides a convenient way to interact with the JPRED (Protein Secondary Structure Prediction) server. It allows you to submit protein sequences and retrieve the predicted secondary structure information. This is particularly useful for bioinformatics tasks where understanding protein structure is crucial. The tool can be used as a Python library or directly via its command-line interface (CLI).

  ## Usage Instructions

  The `jpredapi` tool can be installed via conda or pip.

  **Installation:**

  Using Conda:
  ```bash
  conda install bioconda::jpredapi
  ```

  Using Pip:
  ```bash
  python3 -m pip install jpredapi
  ```
  or
  ```bash
  py -3 -m pip install jpredapi
  ```

  **Command-Line Interface (CLI) Usage:**

  The primary command for using `jpredapi` is `jpredapi`.

  **Submitting a job:**

  To submit a job, you typically provide the protein sequence directly or via a file.

  *   **Submitting a sequence directly:**
      ```bash
      jpredapi --sequence YOUR_PROTEIN_SEQUENCE
      ```
      Replace `YOUR_PROTEIN_SEQUENCE` with the actual amino acid sequence.

  *   **Submitting a sequence from a file:**
      ```bash
      jpredapi --file path/to/your/sequence.fasta
      ```
      The input file should be in FASTA format.

  **Retrieving results:**

  After submitting a job, you will receive a job ID. You can use this job ID to retrieve the results.

  *   **Retrieving results using job ID:**
      ```bash
      jpredapi --jobid YOUR_JOB_ID
      ```
      Replace `YOUR_JOB_ID` with the ID obtained from the submission.

  **Advanced Options:**

  *   **Silent mode:** To suppress output messages, use the `--silent` flag.
      ```bash
      jpredapi --sequence YOUR_SEQUENCE --silent
      ```

  **Python Library Usage:**

  The `jpredapi` package can also be used as a Python library. Refer to the official documentation for detailed examples on programmatic usage.

  ## Expert Tips

  *   **FASTA Format:** Ensure your input sequence file is correctly formatted in FASTA. This typically includes a header line starting with '>' followed by the sequence on subsequent lines.
  *   **Job ID Management:** Keep track of your job IDs, especially when submitting multiple sequences. This is essential for retrieving specific results later.
  *   **Error Handling:** Be prepared to handle potential errors, such as invalid sequences or server issues. The tool's output or return codes can provide clues for debugging.
  *   **Check Documentation:** For the most up-to-date information and advanced features, consult the official documentation on ReadTheDocs.

  ## Reference documentation
  - [jpredapi @ GitHub](./references/github_com_MoseleyBioinformaticsLab_jpredapi.md)
  - [jpredapi Overview (Anaconda.org)](./references/anaconda_org_channels_bioconda_packages_jpredapi_overview.md)