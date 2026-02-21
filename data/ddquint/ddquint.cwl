cwlVersion: v1.2
class: CommandLineTool
baseCommand: ddquint
label: ddquint
doc: "ddquint tool (Help text unavailable in provided input)\n\nTool homepage: https://github.com/globuzzz2000/ddQuint"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ddquint:0.1.0--pyhdfd78af_0
stdout: ddquint.out
