cwlVersion: v1.2
class: CommandLineTool
baseCommand: svseq2
label: svseq2
doc: "The provided text does not contain help information or usage instructions for
  svseq2. It appears to be an error log from a container runtime (Apptainer/Singularity)
  failing to fetch or build the image.\n\nTool homepage: https://sourceforge.net/projects/svseq2/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svseq2:2--h077b44d_0
stdout: svseq2.out
