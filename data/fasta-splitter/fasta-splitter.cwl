cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasta-splitter
label: fasta-splitter
doc: "The provided text does not contain help information or a description of the
  tool; it contains system log messages and a fatal error regarding container image
  building (no space left on device).\n\nTool homepage: http://kirill-kryukov.com/study/tools/fasta-splitter/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasta-splitter:0.2.6--0
stdout: fasta-splitter.out
