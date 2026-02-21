cwlVersion: v1.2
class: CommandLineTool
baseCommand: anansnake
label: anansnake
doc: "A tool for the analysis of ANANSE (Gene Regulatory Network) workflows.\n\nTool
  homepage: https://github.com/vanheeringen-lab/anansnake"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anansnake:0.1.0--pyh7cba7a3_0
stdout: anansnake.out
