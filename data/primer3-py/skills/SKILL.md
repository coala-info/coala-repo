---
name: primer3-py
description: The `primer3-py` skill provides a high-performance Pythonic interface to the Primer3 library, the industry standard for primer design.
homepage: https://github.com/libnano/primer3-py
---

# primer3-py

## Overview
The `primer3-py` skill provides a high-performance Pythonic interface to the Primer3 library, the industry standard for primer design. This tool is essential for bioinformatics workflows requiring rapid thermodynamic calculations for DNA sequences. It replaces slow subprocess-based wrappers with direct C-bindings, making it suitable for large-scale oligo analysis and automated primer picking pipelines.

## Core Oligo Analysis
Use the following methods for quick thermodynamic evaluation of single or paired sequences.

### Melting Temperature (Tm)
Calculate the melting temperature of a sequence using the default Primer3 parameters:
```python
import primer3
tm = primer3.calc_tm('GTAAAACGACGGCCAGT')
```

### Secondary Structures
Analyze sequences for hairpins or dimers. These functions return a `ThermoResult` object containing `structure_found`, `tm`, `dg`, `dh`, and `ds`.

*   **Hairpins**: `primer3.calc_hairpin('CCCCCATCCGATCAGGGGG')`
*   **Homodimers**: `primer3.calc_homodimer('GTAAAACGACGGCCAGT')`
*   **Heterodimers**: `primer3.calc_heterodimer('GTAAAACGACGGCCAGT', 'ACTG...')`

## Primer Design Engine
For complex primer design, use the `design_primers` binding. This requires two dictionaries: one for sequence information and one for global configuration parameters.

### Input Structure
1.  **Sequence Dictionary**: Must include `SEQUENCE_ID` and `SEQUENCE_TEMPLATE`. Optional tags include `SEQUENCE_TARGET` or `SEQUENCE_INCLUDED_REGION`.
2.  **Global Dictionary**: Contains design constraints like `PRIMER_OPT_SIZE`, `PRIMER_MIN_TM`, and `PRIMER_MAX_POLY_X`.

### Implementation Pattern
```python
import primer3

seq_args = {
    'SEQUENCE_ID': 'example',
    'SEQUENCE_TEMPLATE': 'GCTAGCTAGCTAGCTA...',
}

global_args = {
    'PRIMER_OPT_SIZE': 20,
    'PRIMER_PICK_INTERNAL_OLIGO': 1,
    'PRIMER_INTERNAL_OPT_SIZE': 20,
    'PRIMER_OPT_TM': 60.0,
    'PRIMER_MIN_TM': 57.0,
    'PRIMER_MAX_TM': 63.0,
}

results = primer3.bindings.design_primers(seq_args, global_args)
```

## Expert Tips and Best Practices
*   **Performance**: Always prefer `primer3-py` over calling the `primer3_core` executable via `subprocess`. It is approximately 1000x faster for batch operations.
*   **Parameter Parity**: The keys used in the input dictionaries for `design_primers` match the Primer3 manual tags exactly. Refer to the Primer3 v2.6.1 manual for exhaustive parameter definitions.
*   **Result Handling**: The output of `design_primers` is a dictionary. Primer pairs are indexed (e.g., `PRIMER_LEFT_0_SEQUENCE`, `PRIMER_RIGHT_0_SEQUENCE`). Always check `PRIMER_PAIR_NUM_RETURNED` to verify if any valid primers were found.
*   **Thermodynamic Alignment**: When calculating dimers, `primer3-py` uses the same thermodynamic models as the web-based Primer3 tool, ensuring consistency between local scripts and online validation.

## Reference documentation
- [primer3-py Overview](./references/github_com_libnano_primer3-py.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_primer3-py_overview.md)