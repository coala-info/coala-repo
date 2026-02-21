cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tgt
  - shift-boundaries
label: tgt_shift-boundaries
doc: "A tool for shifting boundaries (Note: The provided help text contains only container
  runtime error logs and no usage information).\n\nTool homepage: https://github.com/hbuschme/TextGridTools/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tgt:1.4.3--pyh7e72e81_3
stdout: tgt_shift-boundaries.out
