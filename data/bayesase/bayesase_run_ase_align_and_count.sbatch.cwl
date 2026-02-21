cwlVersion: v1.2
class: CommandLineTool
baseCommand: bayesase_run_ase_align_and_count.sbatch
label: bayesase_run_ase_align_and_count.sbatch
doc: "The provided text is an error log from a failed container build process (no
  space left on device) and does not contain CLI help information or argument definitions.\n
  \nTool homepage: https://github.com/McIntyre-Lab/BayesASE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bayesase:21.1.13.1--py_0
stdout: bayesase_run_ase_align_and_count.sbatch.out
