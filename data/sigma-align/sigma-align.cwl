cwlVersion: v1.2
class: CommandLineTool
baseCommand: sigma-align
label: sigma-align
doc: "A tool for multiple alignment of DNA sequences (Note: The provided text contains
  system error messages rather than help documentation, so no arguments could be extracted).\n\
  \nTool homepage: https://github.com/BaccanoEva/SiGMa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sigma-align:v1.1.3-6-deb_cv1
stdout: sigma-align.out
