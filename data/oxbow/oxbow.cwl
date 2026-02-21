cwlVersion: v1.2
class: CommandLineTool
baseCommand: oxbow
label: oxbow
doc: "The provided text does not contain help information or usage instructions; it
  is an error log from a container runtime (Apptainer/Singularity) indicating a failure
  to pull the oxbow image due to insufficient disk space.\n\nTool homepage: https://github.com/abdenlab/oxbow"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oxbow:0.5.1--py310hec43fc7_0
stdout: oxbow.out
