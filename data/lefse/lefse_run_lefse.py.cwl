cwlVersion: v1.2
class: CommandLineTool
baseCommand: lefse_run_lefse.py
label: lefse_run_lefse.py
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container environment (Singularity/Apptainer)
  failing due to insufficient disk space.\n\nTool homepage: https://github.com/SegataLab/lefse"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lefse:1.1.2--pyhdfd78af_0
stdout: lefse_run_lefse.py.out
