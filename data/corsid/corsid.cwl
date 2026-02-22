cwlVersion: v1.2
class: CommandLineTool
baseCommand: corsid
label: corsid
doc: "The provided text does not contain help information or a description of the
  tool's functionality; it is an error log from a container build process.\n\nTool
  homepage: http://github.com/elkebir-group/CORSID"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/corsid:0.1.3--pyh5e36f6f_0
stdout: corsid.out
