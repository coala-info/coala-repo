cwlVersion: v1.2
class: CommandLineTool
baseCommand: flowcraft
label: flowcraft
doc: "FlowCraft is a tool for building and managing NGS pipelines. (Note: The provided
  input text contains system error messages and does not include the actual help documentation
  for the tool.)\n\nTool homepage: https://github.com/assemblerflow/flowcraft"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flowcraft:1.4.1--py_1
stdout: flowcraft.out
