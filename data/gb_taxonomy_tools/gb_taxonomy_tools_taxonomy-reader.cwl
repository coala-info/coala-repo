cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxonomy-reader
label: gb_taxonomy_tools_taxonomy-reader
doc: "A tool from the gb_taxonomy_tools suite, likely used for reading or processing
  taxonomy data. Note: The provided help text contains only system error messages
  regarding container execution and does not list specific arguments.\n\nTool homepage:
  https://github.com/spond/gb_taxonomy_tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gb_taxonomy_tools:1.0.1--h503566f_7
stdout: gb_taxonomy_tools_taxonomy-reader.out
