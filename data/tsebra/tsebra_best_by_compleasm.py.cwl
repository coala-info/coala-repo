cwlVersion: v1.2
class: CommandLineTool
baseCommand: tsebra_best_by_compleasm.py
label: tsebra_best_by_compleasm.py
doc: "The provided text does not contain help information; it is a fatal error log
  from a container runtime (Apptainer/Singularity) indicating a failure to build the
  image due to insufficient disk space.\n\nTool homepage: https://github.com/Gaius-Augustus/TSEBRA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsebra:1.1.2.5--pyhca03a8a_0
stdout: tsebra_best_by_compleasm.py.out
