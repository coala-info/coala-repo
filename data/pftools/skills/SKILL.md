---
name: pftools
description: pftools provides algorithms for constructing and searching generalized sequence profiles against protein or DNA databases. Use when user asks to search a profile against a sequence database, scan a sequence against a profile library, or build profiles from multiple sequence alignments.
homepage: https://web.expasy.org/pftools/
---


# pftools

## Overview
The pftools suite provides specialized algorithms for sequence interpretation using generalized profiles. Unlike standard HMMs, these profiles offer a flexible syntax for representing complex biomolecular motifs. This skill enables the construction of profiles from multiple sequence alignments and the subsequent searching of these profiles against sequence databases (or vice versa) using high-performance tools like `pfsearchV3` and `pfscanV3`.

## Core CLI Patterns

### Searching Sequences with Profiles
The primary tools for searching are `pfsearchV3` (search a profile against a library) and `pfscanV3` (search a sequence against a profile library).

*   **Search a profile against a FASTA database:**
    ```bash
    pfsearchV3 [options] <profile_file> <fasta_file>
    ```
*   **Scan a sequence against a profile database:**
    ```bash
    pfscanV3 [options] <sequence_file> <profile_library>
    ```

### Common Options and Heuristics
*   **Heuristic Search:** Use `-h` to enable the heuristic score, which significantly accelerates searches in version 3.
*   **Output Formats:** Version 3 supports modern bioinformatics formats.
    *   Use `-f` for FASTQ support.
    *   Use `-s` for SAM format output.
*   **Scoring:** Profiles use normalized scores. Refer to the profile header for specific cutoff values (CUT_OFF) defined during profile construction.

### Profile Construction and Management
The suite includes legacy Fortran-based tools and modern C implementations for profile generation.
*   **Testing Installation:** Use the provided test script to verify the environment:
    ```bash
    bash share/examples/test_V3.sh
    ```

## Expert Tips
*   **Generalized Syntax:** pftools profiles are more flexible than standard profile HMMs; they can explicitly define position-specific gap penalties and complex transition rules.
*   **DNA Analysis:** While many profile tools focus on proteins, pftools has native support for DNA sequence motifs and can handle large-scale genomic data.
*   **Normalization:** Always check if a profile has been calibrated. Normalized scores allow for a probabilistic interpretation of the alignment quality, making it easier to distinguish true hits from background noise.

## Reference documentation
- [pftools3 GitHub Repository](./references/github_com_sib-swiss_pftools3.md)