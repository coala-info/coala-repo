---
name: samsift
description: samsift filters and modifies SAM or BAM files by applying Python logic to individual alignment records. Use when user asks to filter reads by mapping quality or sequence content, add custom SAM tags, or modify alignment records using Python expressions.
homepage: https://github.com/karel-brinda/samsift
---


# samsift

## Overview
samsift is a powerful bioinformatics utility that bridges the gap between simple SAM filtering and complex custom scripting. It allows you to apply Python 3 logic directly to every alignment record in a SAM or BAM file. By exposing both standard SAM fields and the underlying PySam `AlignedSegment` object, it enables sophisticated operations like regex-based sequence filtering, dynamic tag creation, and on-the-fly record modification without writing a full standalone script.

## Core Usage Patterns

### Basic Filtering
Use the `-f` flag to provide a Python expression that evaluates to a boolean.
*   **Filter by Mapping Quality:** `samsift -i in.bam -o out.bam -f 'MAPQ > 30'`
*   **Filter by Bitwise Flag:** `samsift -i in.bam -f 'not(FLAG & 0x04)'` (keeps only aligned reads)
*   **Filter by Sequence Content:** `samsift -i in.bam -f 'SEQ.find("AATCC") != -1'`
*   **Regex Filtering:** `samsift -i in.bam -f 're.match(r"^[AT]*$", SEQ)'` (keeps only A/T sequences)

### Advanced Tagging and Modification
Use the `-c` flag to execute Python code on each record. Any two-letter variable defined in this block (except `re`) is automatically converted into a SAM tag.
*   **Calculate Average Quality:** `samsift -i in.bam -c 'ab=1.0*sum(QUALa)/len(QUALa)'` (adds 'ab' tag)
*   **Add a Counter Tag:** `samsift -i in.bam -0 'i=0' -c 'i+=1; ii=i'` (initializes `i` once, then adds 'ii' tag)
*   **Strip Sequences:** `samsift -i in.bam -c 'a.query_sequence=""'` (uses the `a` variable to modify the PySam object directly)

### Initialization and State
Use the `-0` flag for one-time setup, such as importing modules or loading external data.
*   **Filter by a List of Names:** `samsift -i in.bam -0 'q=open("list.txt").read().splitlines()' -f 'QNAME in q'`
*   **Custom Math Operations:** `samsift -i in.bam -0 'import math' -f 'math.log(AS) > 2'`

## Expert Tips

### Available Variables
*   **Standard Fields:** `QNAME`, `FLAG`, `RNAME`, `POS` (1-based), `MAPQ`, `CIGAR`, `RNEXT`, `PNEXT`, `TLEN`, `SEQ`, `QUAL`.
*   **Helper Variables:** 
    *   `QUALa`: Base qualities as an integer array.
    *   `SEQs`, `QUALs`, `QUALsa`: Sequence and quality fields with soft-clipped bases removed.
    *   `RNAMEi`, `RNEXTi`: Reference IDs as integers.
*   **The `a` Variable:** This is the raw `pysam.AlignedSegment` object. Use it for any property or method not exposed by the top-level variables (e.g., `a.is_duplicate`, `a.reference_start`).

### Error Handling Modes (`-m`)
*   `strict` (Default): Stops immediately on any error (e.g., a missing tag in an expression).
*   `nonstop-keep`: Continues on error and keeps the record that caused the error.
*   `nonstop-remove`: Continues on error but discards the record that caused the error. Use this when filtering by tags that may not exist in all records.

### Debugging
Use `-d` to print the result of an expression for specific records, and `-t` to set a trigger for when that debugging output should occur.
*   `samsift -i in.bam -d 'AS' -t 'POS > 1000'` (Prints the 'AS' tag value for all reads past position 1000).

## Reference documentation
- [SAMsift GitHub Repository](./references/github_com_karel-brinda_samsift.md)
- [Bioconda samsift Overview](./references/anaconda_org_channels_bioconda_packages_samsift_overview.md)