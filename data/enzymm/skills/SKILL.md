---
name: enzymm
description: Detects catalytic enzyme residues in protein structures by matching a library of known templates. Use when user asks to identify potential catalytic sites within protein structures, analyze enzyme mechanisms, or compare enzyme active site geometries.
homepage: https://pypi.org/project/enzymm/
metadata:
  docker_image: "quay.io/biocontainers/enzymm:0.3.1--pyhdfd78af_1"
---

# enzymm

Detects catalytic enzyme residues in protein structures by matching a library of known templates.
  Use when Claude needs to identify potential catalytic sites within protein structures, analyze enzyme mechanisms, or compare enzyme active site geometries across different evolutionary distances.
body: |
  ## Overview
  The enzymm tool identifies catalytic sites in protein structures by geometrically matching them against a library of known catalytic site templates. It's particularly useful for exploring enzyme function and evolution when sequence or fold similarity is not apparent.

  ## Usage Instructions

  Enzymm is a command-line tool. Ensure you have it installed (e.g., via `pip install enzymm` or `conda install -c bioconda enzymm`).

  ### Basic Usage

  To run enzymm on a single protein structure:

  ```bash
  enzymm -i <path_to_protein_structure.pdb_or_cif> -o <output_results.tsv>
  ```

  - `-i` or `--input`: Path to the input protein structure file (PDB or mmCIF format).
  - `-o` or `--output`: Path for the output TSV file containing the summary of all identified matches.

  ### Running on Multiple Structures

  To process a list of protein structures:

  ```bash
  enzymm -l <path_to_list_of_structures.txt> -o <output_results.tsv>
  ```

  - `-l` or `--list`: Path to a text file where each line is a path to a protein structure file.

  ### Advanced Options

  *   **Saving PDB alignments**: To save PDB files of the identified matches for visual inspection:
      ```bash
      enzymm -i some_structure.pdb -o results.tsv --pdbs dir_to_save_matches
      ```
      - `--pdbs`: Directory to save the PDB files of matched residues.

  *   **Parallel processing**: Control the number of threads for faster analysis:
      ```bash
      enzymm -i structure.pdb -j 4
      ```
      - `-j` or `--jobs`: Number of threads to use. Defaults to one less than available CPU cores.

  *   **Disabling filtering**: To disable default filtering by RMSD and residue orientation:
      ```bash
      enzymm -i structure.pdb -u
      ```
      - `-u` or `--unfiltered`: Disables filtering.

  *   **Skipping smaller hits**: Optimize by skipping searches with smaller templates if a larger match is found:
      ```bash
      enzymm -i structure.pdb --skip-smaller-hits
      ```

  *   **Customizing thresholds**: Adjust RMSD and pairwise distance thresholds:
      ```bash
      enzymm -i structure.pdb -p <rmsd_threshold> <distance_threshold>
      ```
      - `-p` or `--parameters`: Specify custom thresholds. Refer to the documentation for details.

  *   **Using a custom template library**: Provide your own set of catalytic templates:
      ```bash
      enzymm -i structure.pdb -t /path/to/custom/templates/
      ```
      - `-t` or `--template-dir`: Directory containing custom template files.

  *   **Conservation cutoff**: Exclude atoms with low B-factors or pLDDT scores:
      ```bash
      enzymm -i structure.pdb -c <score_threshold>
      ```
      - `-c` or `--conservation-cutoff`: Threshold for B-factors or pLDDT scores.

  ### Output Details

  The primary output is a TSV file (`.tsv`) containing a summary of all matches.

  When using the `--pdbs` flag, alignment PDB files can be generated:
  - `{pdbs_dir}/{query_identifier}_matches.pdb`: Matched residues in the query's reference frame.
  - `{pdbs_dir}/{template_pdb_identifier}_matches.pdb`: Matches aligned to the template's reference frame (when `--transform` is used).

  Additional information can be included in the PDB files:
  - `--include-template`: Writes the template structure to the PDB file.
  - `--include-query`: Writes the entire query structure to the PDB file.

  ## Reference documentation
  - [Enzymm Documentation](https://enzymm.readthedocs.io/en/latest/)
  - [PyPI - enzymm](https://pypi.org/project/enzymm/)
  - [GitHub Repository](https://github.com/RayHackett/enzymm)