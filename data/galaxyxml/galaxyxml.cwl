cwlVersion: v1.2
class: CommandLineTool
baseCommand: galaxyxml
label: galaxyxml
doc: "A tool for generating Galaxy XML tool wrappers. (Note: The provided help text
  contains only system error logs and no usage information.)\n\nTool homepage: https://github.com/hexylena/galaxyxml/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galaxyxml:0.5.5--pyh7e72e81_0
stdout: galaxyxml.out
