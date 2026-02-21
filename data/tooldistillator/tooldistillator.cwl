cwlVersion: v1.2
class: CommandLineTool
baseCommand: tooldistillator
label: tooldistillator
doc: "ToolDistillator is a tool for distilling and processing bioinformatics tool
  metadata and results.\n\nTool homepage: https://gitlab.com/ifb-elixirfr/abromics"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
stdout: tooldistillator.out
