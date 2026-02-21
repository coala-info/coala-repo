cwlVersion: v1.2
class: CommandLineTool
baseCommand: downpore
label: downpore
doc: "A tool for processing nanopore sequencing data (Note: The provided text contains
  only system error logs and no help documentation).\n\nTool homepage: https://github.com/jteutenberg/downpore"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/downpore:0.3.4--he881be0_1
stdout: downpore.out
