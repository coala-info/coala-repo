cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngscheckmate
label: ngscheckmate
doc: "NGSCheckMate is a tool for checking sample matching between next-generation
  sequencing (NGS) datasets. (Note: The provided text is a system error message regarding
  container execution and does not contain help documentation or argument definitions.)\n
  \nTool homepage: https://github.com/parklab/NGSCheckMate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngscheckmate:1.0.1--py312pl5321h577a1d6_4
stdout: ngscheckmate.out
