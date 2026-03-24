---
name: cwl-molecular-structure-checking
description: "This Common Workflow Language workflow utilizes the BioExcel Building Blocks library to perform comprehensive quality checks and structural repairs on molecular protein structures. Use this skill when you need to ensure the integrity and stability of a protein system by resolving atomic clashes, fixing side-chain issues, and standardizing protonation states prior to initiating molecular dynamics simulations."
homepage: https://workflowhub.eu/workflows/776
---
# CWL Molecular Structure Checking

## Overview

This [Common Workflow Language (CWL)](https://workflowhub.eu/workflows/776) workflow automates the validation and preparation of molecular structures using the [BioExcel Building Blocks (biobb)](https://github.com/bioexcel/biobb) library. It is designed to identify and resolve common structural inconsistencies found in Protein Data Bank (PDB) files—such as the [1Z83](https://www.rcsb.org/structure/1z83) crystal structure—ensuring the resulting models are optimized for Molecular Dynamics (MD) simulations.

The pipeline performs a comprehensive suite of structural refinements, including:
*   **Basic Manipulations:** Selection of specific models, chains, and resolution of alternative locations (altlocs).
*   **Cleanup:** Removal of crystallographic water molecules and unwanted heteroatoms or ligands.
*   **Structural Repairs:** Detection and fixing of missing side-chain atoms, backbone issues, and disulfide bonds.
*   **Chemical Corrections:** Adjustment of amide assignments, chirality, and the addition or removal of hydrogen atoms based on specific criteria.

By automating these preprocessing steps, the workflow minimizes the risk of simulation failures caused by atomic clashes or incomplete residues. Users can also explore an implementation of these tools through the [BioExcel Building Blocks GUI](https://mmb.irbbarcelona.org/biobb-wfs/) for interactive structure checking.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| step0_structure_check_init_input_structure_path | Input file | File | Input structure file path. |
| step0_structure_check_init_output_summary_path | Output file | string | Output summary checking results. |
| step1_extract_model_input_structure_path | Input file | File | Input structure file path. |
| step1_extract_model_output_structure_path | Output file | string | Output structure file path. |
| step1_extract_model_config | Config file | string | Configuration file for biobb_structure_utils.extract_model tool. |
| step2_extract_chain_output_structure_path | Output file | string | Output structure file path. |
| step2_extract_chain_config | Config file | string | Configuration file for biobb_structure_utils.extract_chain tool. |
| step3_fix_altlocs_output_pdb_path | Output file | string | Output PDB file path. |
| step3_fix_altlocs_config | Config file | string | Configuration file for biobb_model.fix_altlocs tool. |
| step4_fix_ssbonds_output_pdb_path | Output file | string | Output PDB file path. |
| step5_remove_molecules_ions_output_molecules_path | Output file | string | Output molcules file path. |
| step5_remove_molecules_ions_config | Config file | string | Configuration file for biobb_structure_utils.remove_molecules tool. |
| step6_remove_molecules_ligands_output_molecules_path | Output file | string | Output molcules file path. |
| step6_remove_molecules_ligands_config | Config file | string | Configuration file for biobb_structure_utils.remove_molecules tool. |
| step7_reduce_remove_hydrogens_output_path | Output file | string | Path to the output file. |
| step8_remove_pdb_water_output_pdb_path | Output file | string | Output PDB file path. |
| step9_fix_amides_output_pdb_path | Output file | string | Output PDB file path. |
| step10_fix_chirality_output_pdb_path | Output file | string | Output PDB file path. |
| step11_fix_side_chain_output_pdb_path | Output file | string | Output PDB file path. |
| step12_fix_backbone_input_fasta_canonical_sequence_path | Input file | File | Input FASTA file path. |
| step12_fix_backbone_output_pdb_path | Output file | string | Output PDB file path. |
| step13_leap_gen_top_output_pdb_path | Output file | string | Output 3D structure PDB file matching the topology file. |
| step13_leap_gen_top_output_top_path | Output file | string | Output topology file (AMBER ParmTop). |
| step13_leap_gen_top_output_crd_path | Output file | string | Output coordinates file (AMBER crd). |
| step13_leap_gen_top_config | Config file | string | Configuration file for biobb_amber.leap_gen_top tool. |
| step14_sander_mdrun_output_traj_path | Output file | string | Output trajectory file. |
| step14_sander_mdrun_output_rst_path | Output file | string | Output restart file. |
| step14_sander_mdrun_output_log_path | Output file | string | Output log file. |
| step14_sander_mdrun_config | Config file | string | Configuration file for biobb_amber.sander_mdrun tool. |
| step15_amber_to_pdb_output_pdb_path | Output file | string | Structure PDB file. |
| step16_fix_pdb_output_pdb_path | Output file | string | Output PDB file path. |
| step17_structure_check_output_summary_path | Output file | string | Output summary checking results. |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| step0_structure_check_init | structure_check | This class is a wrapper of the Structure Checking tool to generate summary checking results on a json file. |
| step1_extract_model | extract_model | This class is a wrapper of the Structure Checking tool to extract a model from a 3D structure. |
| step2_extract_chain | extract_chain | This class is a wrapper of the Structure Checking tool to extract a chain from a 3D structure. |
| step3_fix_altlocs | fix_altlocs | Fix alternate locations from residues. |
| step4_fix_ssbonds | fix_ssbonds | Fix SS bonds from residues. |
| step5_remove_molecules_ions | remove_molecules | Class to remove molecules from a 3D structure using Biopython. |
| step6_remove_molecules_ligands | remove_molecules | Class to remove molecules from a 3D structure using Biopython. |
| step7_reduce_remove_hydrogens | reduce_remove_hydrogens | Removes hydrogen atoms to small molecules. |
| step8_remove_pdb_water | remove_pdb_water | This class is a wrapper of the Structure Checking tool to remove water molecules from PDB 3D structures. |
| step9_fix_amides | fix_amides | Creates a new PDB file flipping the clashing amide groups. |
| step10_fix_chirality | fix_chirality | Creates a new PDB file fixing stereochemical errors in residue side-chains changing It's chirality. |
| step11_fix_side_chain | fix_side_chain | Reconstructs the missing side chains and heavy atoms of the given PDB file. |
| step12_fix_backbone | fix_backbone | Reconstructs the missing backbone atoms of the given PDB file. |
| step13_leap_gen_top | leap_gen_top | Generates a MD topology from a molecule structure using tLeap tool from the AmberTools MD package |
| step14_sander_mdrun | sander_mdrun | Runs energy minimization, molecular dynamics, and NMR refinements using sander tool from the AmberTools MD package |
| step15_amber_to_pdb | amber_to_pdb | Generates a PDB structure from AMBER topology (parmtop) and coordinates (crd) files, using the ambpdb tool from the AmberTools MD package |
| step16_fix_pdb | fix_pdb | Renumerates residues in a PDB structure according to a reference sequence from UniProt |
| step17_structure_check | structure_check | This class is a wrapper of the Structure Checking tool to generate summary checking results on a json file. |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| step0_structure_check_init_out1 | output_summary_path | File | Output summary checking results. |
| step1_extract_model_out1 | output_structure_path | File | Output structure file path. |
| step2_extract_chain_out1 | output_structure_path | File | Output structure file path. |
| step3_fix_altlocs_out1 | output_pdb_path | File | Output PDB file path. |
| step4_fix_ssbonds_out1 | output_pdb_path | File | Output PDB file path. |
| step5_remove_molecules_ions_out1 | output_molecules_path | File | Output molcules file path. |
| step6_remove_molecules_ligands_out1 | output_molecules_path | File | Output molcules file path. |
| step7_reduce_remove_hydrogens_out1 | output_path | File | Path to the output file. |
| step8_remove_pdb_water_out1 | output_pdb_path | File | Output PDB file path. |
| step9_fix_amides_out1 | output_pdb_path | File | Output PDB file path. |
| step10_fix_chirality_out1 | output_pdb_path | File | Output PDB file path. |
| step11_fix_side_chain_out1 | output_pdb_path | File | Output PDB file path. |
| step12_fix_backbone_out1 | output_pdb_path | File | Output PDB file path. |
| step13_leap_gen_top_out1 | output_pdb_path | File | Output 3D structure PDB file matching the topology file. |
| step13_leap_gen_top_out2 | output_top_path | File | Output topology file (AMBER ParmTop). |
| step13_leap_gen_top_out3 | output_crd_path | File | Output coordinates file (AMBER crd). |
| step14_sander_mdrun_out1 | output_traj_path | File | Output trajectory file. |
| step14_sander_mdrun_out2 | output_rst_path | File | Output restart file. |
| step14_sander_mdrun_out3 | output_log_path | File | Output log file. |
| step15_amber_to_pdb_out1 | output_pdb_path | File | Structure PDB file. |
| step16_fix_pdb_out1 | output_pdb_path | File | Output PDB file path. |
| step17_structure_check_out1 | output_summary_path | File | Output summary checking results. |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/776
- `workflow.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
