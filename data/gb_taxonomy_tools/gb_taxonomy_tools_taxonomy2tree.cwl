cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxonomy2tree
label: gb_taxonomy_tools_taxonomy2tree
doc: "A tool to convert taxonomy information into a tree structure. (Note: The provided
  help text contained only system error messages regarding container execution and
  did not list specific arguments.)\n\nTool homepage: https://github.com/spond/gb_taxonomy_tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gb_taxonomy_tools:1.0.1--h503566f_7
stdout: gb_taxonomy_tools_taxonomy2tree.out
