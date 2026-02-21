---
name: voronota
description: Voronota is a specialized software suite designed for the geometric analysis of biological macromolecules.
homepage: https://www.voronota.com/
---

# voronota

## Overview

Voronota is a specialized software suite designed for the geometric analysis of biological macromolecules. It represents atoms as balls with van der Waals radii and constructs Voronoi diagrams to define atomic neighborhoods and contact surfaces. The toolset is divided into a core engine and several expansions: **Voronota-LT** for high-speed parallelized tessellation, **Voronota-JS** for advanced scripting and quality scoring (VoroMQA), and **Voronota-GL** for visualization. Use this skill to automate structural queries, calculate inter-atom contact areas, and perform comparative structural analysis.

## Core CLI Usage

The standard workflow involves converting atomic coordinates into a "balls" format before performing geometric calculations.

### Basic Workflow
1.  **Convert PDB to Balls**:
    `voronota get-balls-from-atoms-file < input.pdb > balls.txt`
2.  **Calculate Vertices**:
    `voronota calculate-vertices < balls.txt > vertices.txt`
3.  **Calculate Contacts**:
    `voronota calculate-contacts < balls.txt > contacts.txt`

### Annotated Contacts and Querying
To perform selection-based analysis, use the query commands:
*   **Annotated Contacts**: `voronota calculate-contacts --annotated < balls.txt > annotated_contacts.txt`
*   **Querying Balls**: `voronota query-balls --match 'C:A,R:10:20' < balls.txt` (Matches Chain A, Residues 10-20).
*   **Querying Contacts**: `voronota query-contacts --match-first 'C:A' --match-second 'C:B' < annotated_contacts.txt` (Finds inter-chain contacts between A and B).

## High-Performance Analysis (Voronota-LT)

Use `voronota-lt` when speed is critical or when processing large ensembles. It uses a radical tessellation (Laguerre-Voronoi diagram) which is significantly faster than the standard additively weighted Voronoi diagram.

*   **Fast Contact Calculation**:
    `voronota-lt -i input.pdb --print-contacts > contacts.txt`
*   **Parallel Execution**:
    `voronota-lt --processors 4 --probe 1.4 -i input.pdb --print-cells > cells.txt`
*   **Membrane Protein Analysis**:
    `voronota-js-membrane-voromqa --input model.pdb --output-dir ./results`

## Model Quality Assessment (Voronota-JS)

The JS expansion provides wrappers for complex scoring methods used in CASP-level assessments.

*   **VoroMQA Scoring**:
    `voronota-js-voromqa --input model.pdb`
*   **CAD-score (Comparative Analysis)**:
    `voronota-js-global-cadscore --target target.pdb --model model.pdb`
*   **Interface Scoring (VoroIF-GNN)**:
    `voronota-js-voroif-gnn --input-target target.pdb --input-model model.pdb`

## Expert Tips

*   **Probe Radius**: The default rolling probe radius is 1.4 Å (standard for water). For pocket analysis, increasing the probe radius (e.g., 2.0 to 5.0 Å) helps identify larger cavities.
*   **Selection Syntax**: Use the colon `:` to define ranges (e.g., `10:50`) and commas `,` for lists. The artificial chain name `solvent` is used to query solvent-accessible areas.
*   **Output Formats**: Most commands output TSV-formatted data. Use `--print-everything` in `voronota-lt` to get a comprehensive dump of contacts, cells, and site summaries in one pass.
*   **Visualization**: Generate SVG plots of contacts directly from the CLI using `--plot-contacts-to-file output.svg`.

## Reference documentation
- [Voronota Main Documentation](./references/www_voronota_com_index.md)
- [Voronota-LT (Fast Tessellation)](./references/www_voronota_com_expansion_lt_index.html.md)
- [Voronota-JS (Scoring and Scripting)](./references/www_voronota_com_expansion_js_index.html.md)
- [Query Arguments Guide](./references/www_voronota_com_support_generate-arguments-for-query-contacts.html.md)