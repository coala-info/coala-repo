cwlVersion: v1.2
class: CommandLineTool
baseCommand: bayesase_run_ase_summarize_counts.sbatch
label: bayesase_run_ase_summarize_counts.sbatch
doc: "The provided text does not contain help information for the tool; it is an error
  log indicating a failure to build a Singularity/Apptainer container due to insufficient
  disk space ('no space left on device').\n\nTool homepage: https://github.com/McIntyre-Lab/BayesASE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bayesase:21.1.13.1--py_0
stdout: bayesase_run_ase_summarize_counts.sbatch.out
