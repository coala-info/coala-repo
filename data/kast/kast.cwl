cwlVersion: v1.2
class: CommandLineTool
baseCommand: kast
label: kast
doc: "K-mer Alignment-free Sequence Comparison Tool\n\nTool homepage: https://github.com/DelphiWorlds/Kastri"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/kast:1.0.1_cv1
stdout: kast.out
