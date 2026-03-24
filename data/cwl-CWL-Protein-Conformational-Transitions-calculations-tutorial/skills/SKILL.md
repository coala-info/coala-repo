---
name: cwl-protein-conformational-transitions-calculations-tutorial
description: "This Common Workflow Language workflow utilizes BioExcel Building Blocks and the GOdMD tool to calculate the conformational transition pathway between two distinct structural states of a protein. Use this skill when you need to characterize the structural rearrangements and dynamic pathways between known protein conformations to understand functional mechanisms or allosteric transitions."
homepage: https://workflowhub.eu/workflows/549
---
# CWL Protein Conformational Transitions calculations tutorial

## Overview

This CWL workflow automates the calculation of conformational transitions between two known protein structural states. Utilizing the [BioExcel Building Blocks (biobb)](https://mmb.irbbarcelona.org/biobb/) library and the GOdMD tool, the pipeline simulates the pathway a protein takes when moving from an initial conformation to a target conformation.

The process begins with structural preprocessing, where specific protein chains are isolated and non-protein molecules are removed to clean the input data. These refined structures are then processed through a preparation stage to configure the system for the GOdMD engine.

The core of the workflow executes the GOdMD simulation to compute the transition trajectory. Finally, the output is processed using `cpptraj` to convert the trajectory data into standard formats suitable for visualization and further analysis. Detailed documentation and version history can be found on [WorkflowHub](https://workflowhub.eu/workflows/549).

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| step0_extract_chain_input_structure_path | Input file | File | Input structure file path. |
| step0_extract_chain_output_structure_path | Output file | string | Output structure file path. |
| step0_extract_chain_config | Config file | string | Configuration file for biobb_structure_utils.extract_chain tool. |
| step1_extract_chain_input_structure_path | Input file | File | Input structure file path. |
| step1_extract_chain_output_structure_path | Output file | string | Output structure file path. |
| step1_extract_chain_config | Config file | string | Configuration file for biobb_structure_utils.extract_chain tool. |
| step2_remove_molecules_output_molecules_path | Output file | string | Output molcules file path. |
| step2_remove_molecules_config | Config file | string | Configuration file for biobb_structure_utils.remove_molecules tool. |
| step4_godmd_prep_output_aln_orig_path | Output file | string | Output GOdMD alignment file corresponding to the origin structure of the conformational transition. |
| step4_godmd_prep_output_aln_target_path | Output file | string | Output GOdMD alignment file corresponding to the target structure of the conformational transition. |
| step4_godmd_prep_config | Config file | string | Configuration file for biobb_godmd.godmd_prep tool. |
| step5_godmd_run_output_log_path | Output file | string | Output log file. |
| step5_godmd_run_output_ene_path | Output file | string | Output energy file. |
| step5_godmd_run_output_trj_path | Output file | string | Output trajectory file. |
| step5_godmd_run_output_pdb_path | Output file | string | Output structure file. |
| step5_godmd_run_config | Config file | string | Configuration file for biobb_godmd.godmd_run tool. |
| step6_cpptraj_convert_output_cpptraj_path | Output file | string | Path to the output processed trajectory. |
| step6_cpptraj_convert_config | Config file | string | Configuration file for biobb_analysis.cpptraj_convert tool. |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| step0_extract_chain | extract_chain | This class is a wrapper of the Structure Checking tool to extract a chain from a 3D structure. |
| step1_extract_chain | extract_chain | This class is a wrapper of the Structure Checking tool to extract a chain from a 3D structure. |
| step2_remove_molecules | remove_molecules | Class to remove molecules from a 3D structure using Biopython. |
| step4_godmd_prep | godmd_prep | Helper BioBB to prepare inputs for the GOdMD tool (protein conformational transitions). |
| step5_godmd_run | godmd_run | Wrapper of the GOdMD tool to compute protein conformational transitions. |
| step6_cpptraj_convert | cpptraj_convert | Wrapper of the Ambertools Cpptraj module for converting between cpptraj compatible trajectory file formats and/or extracting a selection of atoms or frames. |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| step0_extract_chain_out1 | output_structure_path | File | Output structure file path. |
| step1_extract_chain_out1 | output_structure_path | File | Output structure file path. |
| step2_remove_molecules_out1 | output_molecules_path | File | Output molcules file path. |
| step4_godmd_prep_out1 | output_aln_orig_path | File | Output GOdMD alignment file corresponding to the origin structure of the conformational transition. |
| step4_godmd_prep_out2 | output_aln_target_path | File | Output GOdMD alignment file corresponding to the target structure of the conformational transition. |
| step5_godmd_run_out1 | output_log_path | File | Output log file. |
| step5_godmd_run_out2 | output_ene_path | File | Output energy file. |
| step5_godmd_run_out3 | output_trj_path | File | Output trajectory file. |
| step5_godmd_run_out4 | output_pdb_path | File | Output structure file. |
| step6_cpptraj_convert_out1 | output_cpptraj_path | File | Path to the output processed trajectory. |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/549
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
