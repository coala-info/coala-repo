cwlVersion: v1.2
class: CommandLineTool
baseCommand: optimir
label: optimir
doc: "The provided text does not contain help information for the tool; it is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to build
  the image due to lack of disk space.\n\nTool homepage: https://github.com/FlorianThibord/OptimiR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/optimir:1.2--pyh5e36f6f_0
stdout: optimir.out
