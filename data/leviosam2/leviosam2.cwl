cwlVersion: v1.2
class: CommandLineTool
baseCommand: leviosam2
label: leviosam2
doc: "The provided text is a system error message (out of disk space) and does not
  contain the help documentation for leviosam2. Leviosam2 is typically used for lifting
  over genomic alignments using a chain file.\n\nTool homepage: https://github.com/milkschen/leviosam2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/leviosam2:0.5.0--h4ac6f70_0
stdout: leviosam2.out
