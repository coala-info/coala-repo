cwlVersion: v1.2
class: CommandLineTool
baseCommand: omark
label: omark
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Singularity/Apptainer) indicating
  a failure to build the image due to insufficient disk space.\n\nTool homepage: https://github.com/DessimozLab/omark"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/omark:0.4.1--pyh7e72e81_0
stdout: omark.out
