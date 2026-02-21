cwlVersion: v1.2
class: CommandLineTool
baseCommand: prosic
label: prosic
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs from a container build process (Apptainer/Singularity).\n
  \nTool homepage: https://prosic.github.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prosic:2.1.2--h090ddda_0
stdout: prosic.out
