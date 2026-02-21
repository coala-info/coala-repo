cwlVersion: v1.2
class: CommandLineTool
baseCommand: gb_taxonomy_tools
label: gb_taxonomy_tools
doc: "GenBank taxonomy tools (Note: The provided help text contains a fatal error
  message regarding container building and does not list usage instructions or arguments).\n
  \nTool homepage: https://github.com/spond/gb_taxonomy_tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gb_taxonomy_tools:1.0.1--h503566f_7
stdout: gb_taxonomy_tools.out
