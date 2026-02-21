cwlVersion: v1.2
class: CommandLineTool
baseCommand: sickle
label: sickle
doc: "A windowed adaptive trimming tool for FASTQ files using quality\n\nTool homepage:
  http://github.com/mloesch/sickle"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sickle:0.7.0--pyh9f0ad1d_0
stdout: sickle.out
