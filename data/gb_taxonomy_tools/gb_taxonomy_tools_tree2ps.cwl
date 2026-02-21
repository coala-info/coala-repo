cwlVersion: v1.2
class: CommandLineTool
baseCommand: gb_taxonomy_tools_tree2ps
label: gb_taxonomy_tools_tree2ps
doc: "A tool from the gb_taxonomy_tools suite (description unavailable due to execution
  error).\n\nTool homepage: https://github.com/spond/gb_taxonomy_tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gb_taxonomy_tools:1.0.1--h503566f_7
stdout: gb_taxonomy_tools_tree2ps.out
