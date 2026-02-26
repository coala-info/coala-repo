---
name: logol-bin
description: Logol is a biological pattern matching tool that uses a grammar language to identify complex structures in nucleic or proteic sequences. Use when user asks to search for complex biological patterns, execute searches against single or multiple sequences, or convert search results into GFF or FASTA formats.
homepage: https://github.com/genouest/logol
---


# logol-bin

## Overview
Logol is a specialized biological pattern matching tool that utilizes a unique grammar language to identify complex structures in nucleic or proteic sequences. Unlike standard motif search tools, Logol allows for the description of patterns using a logic-programming approach, making it ideal for identifying structural features with variable spacers, repeats, or specific biological constraints. This skill facilitates the workflow of setting up the Logol environment, executing searches against single or multiple sequences, and post-processing the results.

## Environment Setup and Configuration
Before running searches, the Logol environment must be correctly configured to handle temporary files and results.

- **Configuration File**: Primary settings are stored in `prolog/logol.properties`.
- **Key Parameters**:
    - `dir.result`: The directory where search results will be stored.
    - `workingDir`: A temporary directory used for file creation during the Prolog execution phase.
- **Suffix Array Tools**: Ensure either `Cassiopee` (Ruby gem) or `VMatch` is installed and accessible. If using VMatch, the path must be specified in `prolog/suffixSearch.rb`.

## Execution Patterns
Logol provides different entry points depending on the scale of the search.

- **Single Sequence Search**: Use `LogolExec.sh` (or `LogolExec.rb` on Windows) when matching a grammar against a single input sequence.
- **Bank/Multiple Sequence Search**: Use `LogolMultiExec.sh` (or `LogolMultiExec.rb` on Windows) for high-throughput searches against sequence databases or multiple files.
- **Verification**: Always run `logolTest.sh` from the installation directory after setup to ensure the Java, Ruby, and Prolog components are communicating correctly.

## Output Management and Conversion
Logol's raw output can be converted into standard formats for downstream analysis using the provided utility scripts in the root directory.

- **GFF Conversion**: Use `convert2gff.sh` to transform match results into General Feature Format, suitable for loading into genome browsers.
- **Fasta Extraction**: Use `convert2fasta.sh` to extract the sequence segments that matched the grammar.
- **Model Mapping**: Use `MatchToModel.sh` to relate matches back to the original grammar model.

## Best Practices
- **Pathing**: On Windows systems, ensure that installation and working directories do not contain whitespaces or accented characters, as these can break the Prolog execution string.
- **Memory Management**: For large sequence banks, monitor the `workingDir` as Logol generates intermediate Prolog files that can consume significant disk space.
- **Grammar Documentation**: If the logic of a specific grammar is unclear, use the `generate-doc.sh` tool in the `tools/` directory to produce a PDF or HTML representation of the grammar rules.

## Reference documentation
- [Logol GitHub Repository](./references/github_com_genouest_logol.md)
- [Bioconda Logol Overview](./references/anaconda_org_channels_bioconda_packages_logol_overview.md)