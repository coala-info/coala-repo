cwlVersion: v1.2
class: CommandLineTool
baseCommand: mark-nonconverted-reads
label: mark-nonconverted-reads
doc: "A tool to mark non-converted reads (Note: The provided text contains container
  runtime error messages and does not include the actual help documentation or argument
  list).\n\nTool homepage: https://github.com/nebiolabs/mark-nonconverted-reads"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mark-nonconverted-reads:1.2--pyhdfd78af_0
stdout: mark-nonconverted-reads.out
