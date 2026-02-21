---
name: aacon
description: "Could not get help from Singularity for: aacon"
homepage: https://www.compbio.dundee.ac.uk/aacon/
---

# aacon

## Overview

AACon (Amino Acid Conservation) is a high-performance toolset designed to identify functional sites in proteins by measuring evolutionary conservation. It implements 17 metrics reviewed by Valdar (such as Kabat, Jores, and Schneider) alongside the SMERFS algorithm. This skill enables the execution of conservation analysis on protein alignments, allowing for rapid processing of large datasets, result normalization for cross-method comparison, and customization of gap handling or algorithm-specific parameters.

## Standalone CLI Usage

The standalone tool is typically distributed as a JAR file (e.g., `compbio-conservation-1.1.jar`).

### Basic Execution
To calculate conservation for an alignment using a specific method:
`java -jar aacon.jar -i=<input_file> -m=<METHOD>`

### Common Methods
- **Fast Methods**: KABAT, JORES, SCHNEIDER, SHENKIN, GERSTEIN, TAYLOR_GAPS, TAYLOR_NO_GAPS, ZVELIBIL, ARMON, THOMPSON, NOT_LANCET, MIRNY, WILLIAMSON.
- **Slow/Complex Methods**: LANDGRAF, KARLIN, SANDER, VALDAR, SMERFS.

### Expert CLI Patterns

**1. Multi-Method Analysis**
Calculate scores for multiple methods simultaneously by providing a comma-separated list:
`java -jar aacon.jar -i=alignment.fasta -m=SANDER,KABAT,VALDAR`

**2. Normalizing Results**
Use the `-n` flag to scale all scores between 0 and 1, making results from different algorithms comparable:
`java -jar aacon.jar -i=alignment.fasta -n`

**3. Custom Gap Handling**
If your alignment uses non-standard gap characters (e.g., underscores or 'x'), define them explicitly:
`java -jar aacon.jar -i=alignment.fasta -m=KABAT -g=-,_,x`

**4. Advanced SMERFS Configuration**
SMERFS requires specific parameters: window width (odd integer), scoring method (MID_SCORE or MAX_SCORE), and gap percentage cutoff (0 to 1):
`java -jar aacon.jar -i=alignment.fasta -m=SMERFS -s=5,MID_SCORE,0.1`

**5. Output Formatting**
By default, AACon outputs only scores (`RESULT_NO_ALIGNMENT`). To include the original alignment in the output file:
`java -jar aacon.jar -i=alignment.fasta -f=RESULT_WITH_ALIGNMENT -o=output.txt`

## Web Service Client Usage

For remote execution via the University of Dundee's infrastructure, use the `aacon-client.jar`.

### Discovery Actions
- **List Presets**: `java -jar aacon-client.jar -presets`
- **List Parameters**: `java -jar aacon-client.jar -parameters`
- **Check Limits**: `java -jar aacon-client.jar -limits`

### Execution via Presets
Presets group methods by execution speed:
- **Quick**: `java -jar aacon-client.jar -i=input.fasta -r="Quick conservation"`
- **Complete**: `java -jar aacon-client.jar -i=input.fasta -r="Complete conservation"`

## Best Practices
- **Input Validation**: Ensure all sequences in the input file are of equal length; AACon requires a pre-aligned input (MSA).
- **Large Alignments**: The web service has a limit of 5000 sequences × 1000 residues. For datasets exceeding this, always use the standalone CLI.
- **Resource Management**: When using the Java library directly, initialize only one `ExecutorService` to avoid resource exhaustion during parallel processing.

## Reference documentation
- [Standalone Client Documentation](./references/www_compbio_dundee_ac_uk_aacon_docs_client.html.md)
- [Included Methods and Algorithms](./references/www_compbio_dundee_ac_uk_aacon_docs_methods.html.md)
- [Web Service Client Guide](./references/www_compbio_dundee_ac_uk_aacon_docs_webservice.html.md)
- [Java Library Usage](./references/www_compbio_dundee_ac_uk_aacon_docs_library.html.md)