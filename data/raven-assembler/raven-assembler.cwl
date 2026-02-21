cwlVersion: v1.2
class: CommandLineTool
baseCommand: raven
label: raven-assembler
doc: "Raven is a de novo assembler for long reads (e.g., Oxford Nanopore Technologies
  or Pacific Biosciences). Note: The provided text appears to be a container build
  error log rather than help text, so no arguments could be extracted.\n\nTool homepage:
  https://github.com/lbcb-sci/raven"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/raven-assembler:1.8.3--h5ca1c30_3
stdout: raven-assembler.out
