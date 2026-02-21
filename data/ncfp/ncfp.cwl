cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncfp
label: ncfp
doc: "NCBI Feature Parser (Note: The provided text is a container runtime error message
  and does not contain help or usage information for the tool itself).\n\nTool homepage:
  http://widdowquinn.github.io/ncfp/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncfp:0.2.0--py_0
stdout: ncfp.out
