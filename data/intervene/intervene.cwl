cwlVersion: v1.2
class: CommandLineTool
baseCommand: intervene
label: intervene
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container runtime (Singularity/Apptainer)
  failing to build the image due to insufficient disk space.\n\nTool homepage: https://github.com/asntech/intervene"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/intervene:0.6.5--pyh3252c3a_1
stdout: intervene.out
