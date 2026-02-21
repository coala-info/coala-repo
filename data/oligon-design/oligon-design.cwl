cwlVersion: v1.2
class: CommandLineTool
baseCommand: oligon-design
label: oligon-design
doc: "A tool for designing oligonucleotides (Note: The provided text contains system
  error messages regarding container execution and does not list specific command-line
  arguments).\n\nTool homepage: https://github.com/MiguelMSandin/oligoN-design"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oligon-design:1.0.0--py314hdfd78af_0
stdout: oligon-design.out
