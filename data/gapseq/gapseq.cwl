cwlVersion: v1.2
class: CommandLineTool
baseCommand: gapseq
label: gapseq
doc: "The provided text does not contain help information for gapseq; it contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull the gapseq image due to insufficient disk space.\n\nTool homepage: https://github.com/jotech/gapseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gapseq:1.4.0--h9ee0642_1
stdout: gapseq.out
