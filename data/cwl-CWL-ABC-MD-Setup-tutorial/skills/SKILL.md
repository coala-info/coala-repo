---
name: cwl-abc-md-setup-tutorial
description: This Common Workflow Language workflow automates the preparation of protein molecular dynamics simulation systems by utilizing BioExcel Building Blocks to interface with AmberTools for topology generation, solvation, and neutralization. Use this skill when you need to generate equilibrated protein structures and topologies for atomistic molecular dynamics studies to investigate protein stability or conformational changes.
homepage: https://mmb.irbbarcelona.org/biobb/
metadata:
  docker_image: "N/A"
---

# cwl-abc-md-setup-tutorial

## Overview

This [Common Workflow Language (CWL)](https://workflowhub.eu/workflows/262) workflow automates the structural setup and initial simulation of a protein system. It utilizes the [BioExcel Building Blocks (biobb)](https://mmb.irbbarcelona.org/biobb/) library to wrap [AmberTools](https://ambermd.org/AmberTools.php) utilities, providing a standardized pipeline for molecular dynamics (MD) preparation.

The workflow follows a comprehensive preparation and simulation sequence:
*   **System Preparation:** Generates the system topology, solvates the protein, and adds/randomizes ions to neutralize the environment.
*   **Optimization:** Performs hydrogen mass repartitioning via Parmed to improve simulation stability and efficiency.
*   **Execution:** Runs molecular dynamics simulations (including minimization) using the Sander engine and processes the resulting output files for analysis.

Modeled after the classic [GROMACS lysozyme tutorial](http://www.mdtutorials.com/gmx/lysozyme/index.html), this workflow adapts the process for the Amber software ecosystem. It is maintained by the MMB group at the Barcelona Supercomputing Center and is licensed under [Apache-2.0](https://www.apache.org/licenses/LICENSE-2.0).

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| step1_leap_gen_top_config |  | string |  |
| step1_leap_gen_top_input_pdb_path |  | File |  |
| step1_leap_gen_top_output_pdb_path |  | string |  |
| step1_leap_gen_top_output_top_path |  | string |  |
| step1_leap_gen_top_output_crd_path |  | string |  |
| step2_leap_solvate_config |  | string |  |
| step2_leap_solvate_output_pdb_path |  | string |  |
| step2_leap_solvate_output_top_path |  | string |  |
| step2_leap_solvate_output_crd_path |  | string |  |
| step3_leap_add_ions_config |  | string |  |
| step3_leap_add_ions_output_pdb_path |  | string |  |
| step3_leap_add_ions_output_top_path |  | string |  |
| step3_leap_add_ions_output_crd_path |  | string |  |
| step4_cpptraj_randomize_ions_config |  | string |  |
| step4_cpptraj_randomize_ions_output_pdb_path |  | string |  |
| step4_cpptraj_randomize_ions_output_crd_path |  | string |  |
| step5_parmed_hmassrepartition_output_top_path |  | string |  |
| step6_sander_mdrun_eq1_config |  | string |  |
| step6_sander_mdrun_eq1_input_mdin_path |  | File |  |
| step6_sander_mdrun_eq1_output_traj_path |  | string |  |
| step6_sander_mdrun_eq1_output_rst_path |  | string |  |
| step6_sander_mdrun_eq1_output_log_path |  | string |  |
| step6_sander_mdrun_eq1_output_mdinfo_path |  | string |  |
| step7_process_minout_eq1_config |  | string |  |
| step7_process_minout_eq1_output_dat_path |  | string |  |
| step8_sander_mdrun_eq2_config |  | string |  |
| step8_sander_mdrun_eq2_input_mdin_path |  | File |  |
| step8_sander_mdrun_eq2_output_traj_path |  | string |  |
| step8_sander_mdrun_eq2_output_rst_path |  | string |  |
| step8_sander_mdrun_eq2_output_log_path |  | string |  |
| step8_sander_mdrun_eq2_output_mdinfo_path |  | string |  |
| step9_process_mdout_eq2_config |  | string |  |
| step9_process_mdout_eq2_output_dat_path |  | string |  |
| step10_sander_mdrun_eq3_config |  | string |  |
| step10_sander_mdrun_eq3_input_mdin_path |  | File |  |
| step10_sander_mdrun_eq3_output_traj_path |  | string |  |
| step10_sander_mdrun_eq3_output_rst_path |  | string |  |
| step10_sander_mdrun_eq3_output_log_path |  | string |  |
| step10_sander_mdrun_eq3_output_mdinfo_path |  | string |  |
| step11_process_minout_eq3_config |  | string |  |
| step11_process_minout_eq3_output_dat_path |  | string |  |
| step12_sander_mdrun_eq4_config |  | string |  |
| step12_sander_mdrun_eq4_input_mdin_path |  | File |  |
| step12_sander_mdrun_eq4_output_traj_path |  | string |  |
| step12_sander_mdrun_eq4_output_rst_path |  | string |  |
| step12_sander_mdrun_eq4_output_log_path |  | string |  |
| step12_sander_mdrun_eq4_output_mdinfo_path |  | string |  |
| step13_process_minout_eq4_config |  | string |  |
| step13_process_minout_eq4_output_dat_path |  | string |  |
| step14_sander_mdrun_eq5_config |  | string |  |
| step14_sander_mdrun_eq5_input_mdin_path |  | File |  |
| step14_sander_mdrun_eq5_output_traj_path |  | string |  |
| step14_sander_mdrun_eq5_output_rst_path |  | string |  |
| step14_sander_mdrun_eq5_output_log_path |  | string |  |
| step14_sander_mdrun_eq5_output_mdinfo_path |  | string |  |
| step15_process_minout_eq5_config |  | string |  |
| step15_process_minout_eq5_output_dat_path |  | string |  |
| step16_sander_mdrun_eq6_config |  | string |  |
| step16_sander_mdrun_eq6_input_mdin_path |  | File |  |
| step16_sander_mdrun_eq6_output_traj_path |  | string |  |
| step16_sander_mdrun_eq6_output_rst_path |  | string |  |
| step16_sander_mdrun_eq6_output_log_path |  | string |  |
| step16_sander_mdrun_eq6_output_mdinfo_path |  | string |  |
| step17_process_mdout_eq6_config |  | string |  |
| step17_process_mdout_eq6_output_dat_path |  | string |  |
| step18_sander_mdrun_eq7_config |  | string |  |
| step18_sander_mdrun_eq7_input_mdin_path |  | File |  |
| step18_sander_mdrun_eq7_output_traj_path |  | string |  |
| step18_sander_mdrun_eq7_output_rst_path |  | string |  |
| step18_sander_mdrun_eq7_output_log_path |  | string |  |
| step18_sander_mdrun_eq7_output_mdinfo_path |  | string |  |
| step19_process_mdout_eq7_config |  | string |  |
| step19_process_mdout_eq7_output_dat_path |  | string |  |
| step20_sander_mdrun_eq8_config |  | string |  |
| step20_sander_mdrun_eq8_input_mdin_path |  | File |  |
| step20_sander_mdrun_eq8_output_traj_path |  | string |  |
| step20_sander_mdrun_eq8_output_rst_path |  | string |  |
| step20_sander_mdrun_eq8_output_log_path |  | string |  |
| step20_sander_mdrun_eq8_output_mdinfo_path |  | string |  |
| step21_process_mdout_eq8_config |  | string |  |
| step21_process_mdout_eq8_output_dat_path |  | string |  |
| step22_sander_mdrun_eq9_config |  | string |  |
| step22_sander_mdrun_eq9_input_mdin_path |  | File |  |
| step22_sander_mdrun_eq9_output_traj_path |  | string |  |
| step22_sander_mdrun_eq9_output_rst_path |  | string |  |
| step22_sander_mdrun_eq9_output_log_path |  | string |  |
| step22_sander_mdrun_eq9_output_mdinfo_path |  | string |  |
| step23_process_mdout_eq9_config |  | string |  |
| step23_process_mdout_eq9_output_dat_path |  | string |  |
| step24_sander_mdrun_eq10_config |  | string |  |
| step24_sander_mdrun_eq10_input_mdin_path |  | File |  |
| step24_sander_mdrun_eq10_output_traj_path |  | string |  |
| step24_sander_mdrun_eq10_output_rst_path |  | string |  |
| step24_sander_mdrun_eq10_output_log_path |  | string |  |
| step24_sander_mdrun_eq10_output_mdinfo_path |  | string |  |
| step25_process_mdout_eq10_config |  | string |  |
| step25_process_mdout_eq10_output_dat_path |  | string |  |
| step26_sander_mdrun_md_config |  | string |  |
| step26_sander_mdrun_md_input_mdin_path |  | File |  |
| step26_sander_mdrun_md_output_traj_path |  | string |  |
| step26_sander_mdrun_md_output_rst_path |  | string |  |
| step26_sander_mdrun_md_output_mdinfo_path |  | string |  |
| step26_sander_mdrun_md_output_log_path |  | string |  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| step1_leap_gen_top | LeapGenTop | Generates a MD topology from a molecule structure using tLeap tool from the AmberTools MD package |
| step2_leap_solvate | LeapSolvate | Creates and solvates a system box for an AMBER MD system using tLeap tool from the AmberTools MD package |
| step3_leap_add_ions | LeapAddIons | Adds counterions to a system box for an AMBER MD system using tLeap tool from the AmberTools MD package |
| step4_cpptraj_randomize_ions | CpptrajRandomizeIons | Swap specified ions with randomly selected solvent molecules using cpptraj tool from the AmberTools MD package |
| step5_parmed_hmassrepartition | ParmedHMassRepartition | Performs a Hydrogen Mass Repartition from an AMBER topology file using parmed tool from the AmberTools MD package |
| step6_sander_mdrun_eq1 | SanderMDRun | Runs energy minimization, molecular dynamics, and NMR refinements using sander tool from the AmberTools MD package |
| step7_process_minout_eq1 | ProcessMinOut | Parses the AMBER (sander) minimization output file (log) and dumps statistics that can then be plotted. Using the process_minout.pl tool from the AmberTools MD package |
| step8_sander_mdrun_eq2 | SanderMDRun | Runs energy minimization, molecular dynamics, and NMR refinements using sander tool from the AmberTools MD package |
| step9_process_mdout_eq2 | ProcessMDOut | Parses the AMBER (sander) md output file (log) and dumps statistics that can then be plotted. Using the process_mdout.pl tool from the AmberTools MD package |
| step10_sander_mdrun_eq3 | SanderMDRun | Runs energy minimization, molecular dynamics, and NMR refinements using sander tool from the AmberTools MD package |
| step11_process_minout_eq3 | ProcessMinOut | Parses the AMBER (sander) minimization output file (log) and dumps statistics that can then be plotted. Using the process_minout.pl tool from the AmberTools MD package |
| step12_sander_mdrun_eq4 | SanderMDRun | Runs energy minimization, molecular dynamics, and NMR refinements using sander tool from the AmberTools MD package |
| step13_process_minout_eq4 | ProcessMinOut | Parses the AMBER (sander) minimization output file (log) and dumps statistics that can then be plotted. Using the process_minout.pl tool from the AmberTools MD package |
| step14_sander_mdrun_eq5 | SanderMDRun | Runs energy minimization, molecular dynamics, and NMR refinements using sander tool from the AmberTools MD package |
| step15_process_minout_eq5 | ProcessMinOut | Parses the AMBER (sander) minimization output file (log) and dumps statistics that can then be plotted. Using the process_minout.pl tool from the AmberTools MD package |
| step16_sander_mdrun_eq6 | SanderMDRun | Runs energy minimization, molecular dynamics, and NMR refinements using sander tool from the AmberTools MD package |
| step17_process_mdout_eq6 | ProcessMDOut | Parses the AMBER (sander) md output file (log) and dumps statistics that can then be plotted. Using the process_mdout.pl tool from the AmberTools MD package |
| step18_sander_mdrun_eq7 | SanderMDRun | Runs energy minimization, molecular dynamics, and NMR refinements using sander tool from the AmberTools MD package |
| step19_process_mdout_eq7 | ProcessMDOut | Parses the AMBER (sander) md output file (log) and dumps statistics that can then be plotted. Using the process_mdout.pl tool from the AmberTools MD package |
| step20_sander_mdrun_eq8 | SanderMDRun | Runs energy minimization, molecular dynamics, and NMR refinements using sander tool from the AmberTools MD package |
| step21_process_mdout_eq8 | ProcessMDOut | Parses the AMBER (sander) md output file (log) and dumps statistics that can then be plotted. Using the process_mdout.pl tool from the AmberTools MD package |
| step22_sander_mdrun_eq9 | SanderMDRun | Runs energy minimization, molecular dynamics, and NMR refinements using sander tool from the AmberTools MD package |
| step23_process_mdout_eq9 | ProcessMDOut | Parses the AMBER (sander) md output file (log) and dumps statistics that can then be plotted. Using the process_mdout.pl tool from the AmberTools MD package |
| step24_sander_mdrun_eq10 | SanderMDRun | Runs energy minimization, molecular dynamics, and NMR refinements using sander tool from the AmberTools MD package |
| step25_process_mdout_eq10 | ProcessMDOut | Parses the AMBER (sander) md output file (log) and dumps statistics that can then be plotted. Using the process_mdout.pl tool from the AmberTools MD package |
| step26_sander_mdrun_md | SanderMDRun | Runs energy minimization, molecular dynamics, and NMR refinements using sander tool from the AmberTools MD package |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| step1_leap_gen_top_out1 | output_pdb_path | File | Output 3D structure PDB file matching the topology file |
| step1_leap_gen_top_out2 | output_top_path | File | Output topology file (AMBER ParmTop) |
| step1_leap_gen_top_out3 | output_crd_path | File | Output coordinates file (AMBER crd) |
| step2_leap_solvate_out1 | output_pdb_path | File | Output 3D structure PDB file matching the topology file |
| step2_leap_solvate_out2 | output_top_path | File | Output topology file (AMBER ParmTop) |
| step2_leap_solvate_out3 | output_crd_path | File | Output coordinates file (AMBER crd) |
| step3_leap_add_ions_out1 | output_pdb_path | File | Output 3D structure PDB file matching the topology file |
| step3_leap_add_ions_out2 | output_top_path | File | Output topology file (AMBER ParmTop) |
| step3_leap_add_ions_out3 | output_crd_path | File | Output coordinates file (AMBER crd) |
| step4_cpptraj_randomize_ions_out1 | output_pdb_path | File | Structure PDB file with randomized ions |
| step4_cpptraj_randomize_ions_out2 | output_crd_path | File | Structure CRD file with coordinates including randomized ions |
| step5_parmed_hmassrepartition_out1 | output_top_path | File | Output topology file (AMBER ParmTop) |
| step6_sander_mdrun_eq1_out1 | output_traj_path | File | Output trajectory file |
| step6_sander_mdrun_eq1_out2 | output_rst_path | File | Output restart file |
| step6_sander_mdrun_eq1_out3 | output_log_path | File | Output log file |
| step6_sander_mdrun_eq1_out4 | output_mdinfo_path | File | Output MD info |
| step7_process_minout_eq1_out1 | output_dat_path | File | Dat output file containing data from the specified terms along the minimization process |
| step8_sander_mdrun_eq2_out1 | output_traj_path | File | Output trajectory file |
| step8_sander_mdrun_eq2_out2 | output_rst_path | File | Output restart file |
| step8_sander_mdrun_eq2_out3 | output_log_path | File | Output log file |
| step8_sander_mdrun_eq2_out4 | output_mdinfo_path | File | Output MD info |
| step9_process_mdout_eq2_out1 | output_dat_path | File | Dat output file containing data from the specified terms along the minimization process |
| step10_sander_mdrun_eq3_out1 | output_traj_path | File | Output trajectory file |
| step10_sander_mdrun_eq3_out2 | output_rst_path | File | Output restart file |
| step10_sander_mdrun_eq3_out3 | output_log_path | File | Output log file |
| step10_sander_mdrun_eq3_out4 | output_mdinfo_path | File | Output MD info |
| step11_process_minout_eq3_out1 | output_dat_path | File | Dat output file containing data from the specified terms along the minimization process |
| step12_sander_mdrun_eq4_out1 | output_traj_path | File | Output trajectory file |
| step12_sander_mdrun_eq4_out2 | output_rst_path | File | Output restart file |
| step12_sander_mdrun_eq4_out3 | output_log_path | File | Output log file |
| step12_sander_mdrun_eq4_out4 | output_mdinfo_path | File | Output MD info |
| step13_process_minout_eq4_out1 | output_dat_path | File | Dat output file containing data from the specified terms along the minimization process |
| step14_sander_mdrun_eq5_out1 | output_traj_path | File | Output trajectory file |
| step14_sander_mdrun_eq5_out2 | output_rst_path | File | Output restart file |
| step14_sander_mdrun_eq5_out3 | output_log_path | File | Output log file |
| step14_sander_mdrun_eq5_out4 | output_mdinfo_path | File | Output MD info |
| step15_process_minout_eq5_out1 | output_dat_path | File | Dat output file containing data from the specified terms along the minimization process |
| step16_sander_mdrun_eq6_out1 | output_traj_path | File | Output trajectory file |
| step16_sander_mdrun_eq6_out2 | output_rst_path | File | Output restart file |
| step16_sander_mdrun_eq6_out3 | output_log_path | File | Output log file |
| step16_sander_mdrun_eq6_out4 | output_mdinfo_path | File | Output MD info |
| step17_process_mdout_eq6_out1 | output_dat_path | File | Dat output file containing data from the specified terms along the minimization process |
| step18_sander_mdrun_eq7_out1 | output_traj_path | File | Output trajectory file |
| step18_sander_mdrun_eq7_out2 | output_rst_path | File | Output restart file |
| step18_sander_mdrun_eq7_out3 | output_log_path | File | Output log file |
| step18_sander_mdrun_eq7_out4 | output_mdinfo_path | File | Output MD info |
| step19_process_mdout_eq7_out1 | output_dat_path | File | Dat output file containing data from the specified terms along the minimization process |
| step20_sander_mdrun_eq8_out1 | output_traj_path | File | Output trajectory file |
| step20_sander_mdrun_eq8_out2 | output_rst_path | File | Output restart file |
| step20_sander_mdrun_eq8_out3 | output_log_path | File | Output log file |
| step20_sander_mdrun_eq8_out4 | output_mdinfo_path | File | Output MD info |
| step21_process_mdout_eq8_out1 | output_dat_path | File | Dat output file containing data from the specified terms along the minimization process |
| step22_sander_mdrun_eq9_out1 | output_traj_path | File | Output trajectory file |
| step22_sander_mdrun_eq9_out2 | output_rst_path | File | Output restart file |
| step22_sander_mdrun_eq9_out3 | output_log_path | File | Output log file |
| step22_sander_mdrun_eq9_out4 | output_mdinfo_path | File | Output MD info |
| step23_process_mdout_eq9_out1 | output_dat_path | File | Dat output file containing data from the specified terms along the minimization process |
| step24_sander_mdrun_eq10_out1 | output_traj_path | File | Output trajectory file |
| step24_sander_mdrun_eq10_out2 | output_rst_path | File | Output restart file |
| step24_sander_mdrun_eq10_out3 | output_log_path | File | Output log file |
| step24_sander_mdrun_eq10_out4 | output_mdinfo_path | File | Output MD info |
| step25_process_mdout_eq10_out1 | output_dat_path | File | Dat output file containing data from the specified terms along the minimization process |
| step26_sander_mdrun_md_out1 | output_traj_path | File | Output trajectory file |
| step26_sander_mdrun_md_out2 | output_rst_path | File | Output restart file |
| step26_sander_mdrun_md_out3 | output_mdinfo_path | File | Output MD info |
| step26_sander_mdrun_md_out4 | output_log_path | File | Output log file |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/262
- `workflow.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata