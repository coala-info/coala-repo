cwlVersion: v1.2
class: CommandLineTool
baseCommand: prinseq-plus-plus
label: prinseq-plus-plus
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs from a container runtime (Apptainer/Singularity) failing
  to fetch the image.\n\nTool homepage: https://github.com/Adrian-Cantu/PRINSEQ-plus-plus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prinseq-plus-plus:1.2.4--h077b44d_8
stdout: prinseq-plus-plus.out
