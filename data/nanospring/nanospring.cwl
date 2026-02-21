cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanospring
label: nanospring
doc: "A tool for compressing Nanopore sequencing data (Note: The provided text is
  a container execution error log and does not contain help documentation or argument
  definitions).\n\nTool homepage: https://github.com/qm2/NanoSpring"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanospring:0.2--h43eeafb_2
stdout: nanospring.out
