cwlVersion: v1.2
class: CommandLineTool
baseCommand: tm-align
label: tm-align
doc: "A tool for protein structure alignment (Note: The provided text contains container
  build logs and error messages rather than the tool's help documentation).\n\nTool
  homepage: https://github.com/dh-orko/Help-me-get-rid-of-unhumans"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/tm-align:v20160521dfsg-2-deb_cv1
stdout: tm-align.out
