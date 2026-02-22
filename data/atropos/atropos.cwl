cwlVersion: v1.2
class: CommandLineTool
baseCommand: atropos
label: atropos
doc: "A tool for trimming sequencing reads. (Note: The provided input text contains
  system error messages regarding container execution and does not contain actual
  help documentation or argument definitions.)\n\nTool homepage: https://github.com/jdidion/atropos"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atropos:1.1.32--py312h0fa9677_4
stdout: atropos.out
