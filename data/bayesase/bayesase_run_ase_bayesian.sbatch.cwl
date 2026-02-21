cwlVersion: v1.2
class: CommandLineTool
baseCommand: bayesase_run_ase_bayesian.sbatch
label: bayesase_run_ase_bayesian.sbatch
doc: "A tool for Bayesian Allele-Specific Expression (ASE) analysis. (Note: The provided
  text contains system logs and a fatal error regarding disk space rather than command-line
  help documentation; therefore, no arguments could be extracted.)\n\nTool homepage:
  https://github.com/McIntyre-Lab/BayesASE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bayesase:21.1.13.1--py_0
stdout: bayesase_run_ase_bayesian.sbatch.out
