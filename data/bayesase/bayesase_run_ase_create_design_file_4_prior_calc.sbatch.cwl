cwlVersion: v1.2
class: CommandLineTool
baseCommand: bayesase_run_ase_create_design_file_4_prior_calc.sbatch
label: bayesase_run_ase_create_design_file_4_prior_calc.sbatch
doc: "The provided text does not contain help information for the tool. It consists
  of system logs and a fatal error message regarding a failed container build due
  to insufficient disk space.\n\nTool homepage: https://github.com/McIntyre-Lab/BayesASE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bayesase:21.1.13.1--py_0
stdout: bayesase_run_ase_create_design_file_4_prior_calc.sbatch.out
