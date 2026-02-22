cwlVersion: v1.2
class: CommandLineTool
baseCommand: panx
label: panx
doc: "Pan-genome analysis tool. (Note: The provided text contains system error messages
  regarding disk space and container extraction rather than the tool's help documentation.)\n\
  \nTool homepage: http://pangenome.de"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panx:1.6.0--py27_0
stdout: panx.out
