cwlVersion: v1.2
class: CommandLineTool
baseCommand: isatools
label: isatools
doc: "ISA-tools: metadata tracking for multi-omics experiments (Note: The provided
  text is a system error log and does not contain usage information or argument definitions).\n
  \nTool homepage: https://github.com/ISA-tools/isa-api"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isatools:0.14.3--pyhdfd78af_0
stdout: isatools.out
