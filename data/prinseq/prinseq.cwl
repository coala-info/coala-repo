cwlVersion: v1.2
class: CommandLineTool
baseCommand: prinseq
label: prinseq
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build/fetch process (Apptainer/Singularity).\n
  \nTool homepage: https://github.com/Adrian-Cantu/PRINSEQ-plus-plus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prinseq:0.20.4--4
stdout: prinseq.out
