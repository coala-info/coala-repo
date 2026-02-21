cwlVersion: v1.2
class: CommandLineTool
baseCommand: cortex_con
label: cortex_con
doc: "The provided text does not contain help information or a description for the
  tool; it consists of container runtime logs and an error message indicating the
  executable was not found.\n\nTool homepage: http://cortexassembler.sourceforge.net/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cortex_con:0.04c--0
stdout: cortex_con.out
