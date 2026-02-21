cwlVersion: v1.2
class: CommandLineTool
baseCommand: hapflk_flkpoptree
label: hapflk_flkpoptree
doc: "The provided text contains system error messages and does not include help documentation
  or usage instructions for the tool.\n\nTool homepage: https://github.com/BertrandServin/hapflk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hapflk:1.3.0--py27_0
stdout: hapflk_flkpoptree.out
