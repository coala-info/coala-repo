cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngscheckmate_ncm.py
label: ngscheckmate_ncm.py
doc: "NGSCheckMate is a tool for checking sample matching in next-generation sequencing
  data. (Note: The provided input text contains environment error messages rather
  than the tool's help documentation, so no arguments could be extracted.)\n\nTool
  homepage: https://github.com/parklab/NGSCheckMate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngscheckmate:1.0.1--py312pl5321h577a1d6_4
stdout: ngscheckmate_ncm.py.out
