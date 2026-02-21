cwlVersion: v1.2
class: CommandLineTool
baseCommand: leviathan_LRez
label: leviathan_LRez
doc: "Large-scale read mapping tool (Note: The provided help text contains only container
  runtime error messages and no usage information).\n\nTool homepage: https://github.com/morispi/LEVIATHAN"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/leviathan:1.0.2--h9f5acd7_0
stdout: leviathan_LRez.out
