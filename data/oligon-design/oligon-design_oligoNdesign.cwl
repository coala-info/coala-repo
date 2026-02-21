cwlVersion: v1.2
class: CommandLineTool
baseCommand: oligoNdesign
label: oligon-design_oligoNdesign
doc: "OligoNdesign is a tool for designing oligonucleotides. Note: The provided help
  text contains only system error messages regarding container image conversion and
  does not list specific command-line arguments.\n\nTool homepage: https://github.com/MiguelMSandin/oligoN-design"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oligon-design:1.0.0--py314hdfd78af_0
stdout: oligon-design_oligoNdesign.out
