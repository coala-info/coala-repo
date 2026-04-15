---
name: jronn
description: JRONN detects natively disordered regions in protein sequences using the Regional Order Neural Network algorithm. Use when user asks to predict protein disorder, identify non-structured protein segments, or calculate disorder scores from FASTA files.
homepage: https://biojava.org/
metadata:
  docker_image: "quay.io/biocontainers/jronn:7.1.0--hdfd78af_1"
---

# jronn

## Overview

JRONN is a specialized tool for bioinformatics that implements the Regional Order Neural Network (RONN) algorithm in Java. It is designed to detect natively disordered regions in proteins, which are segments that lack a fixed tertiary structure under physiological conditions. This implementation is optimized for use in automated analysis pipelines and web services, providing identical predictions to the original C-based RONN algorithm while offering better integration for Java-based workflows.

## CLI Usage and Best Practices

The `jronn` tool is typically available as a standalone executable after installation via bioconda. It processes protein sequences in FASTA format and outputs disorder scores for each amino acid residue.

### Basic Command Pattern
The most common way to run jronn is by providing an input FASTA file:

```bash
jronn -i <input_fasta_file>
```

### Common CLI Options
*   `-i <file>`: Specify the input file containing protein sequences in FASTA format.
*   `-o <file>`: (Optional) Redirect the output to a specific file. If not provided, results are typically sent to standard output.
*   `-f <format>`: Some versions allow specifying output formats (e.g., stat, horizontal).

### Interpreting Results
*   **Disorder Scores**: JRONN provides a probability score between 0 and 1 for each residue.
*   **Threshold**: A common threshold for disorder is **0.5**. Residues with a score above 0.5 are generally considered disordered, while those below are considered ordered.
*   **Regional Context**: Because it is a "Regional" neural network, the scores are influenced by the surrounding sequence context, making it more robust than single-residue predictors.

### Performance Tips
*   **Batch Processing**: When analyzing large proteomes, provide a single multi-FASTA file rather than running the tool individually for each sequence to reduce Java Virtual Machine (JVM) startup overhead.
*   **Memory Management**: Since JRONN runs on the JVM, if you encounter `OutOfMemoryError` on very large sequences, you may need to pass memory flags if calling the JAR directly: `java -Xmx2g -jar jronn.jar ...`

## Reference documentation
- [jronn - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_jronn_overview.md)
- [BioJava CookBook](./references/biojava_org_wiki_BioJava_CookBook4.0.md)
- [BioJava Protein Disorder Module](./references/biojava_org_docs_api.md)