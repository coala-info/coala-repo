cwlVersion: v1.2
class: CommandLineTool
baseCommand: nasp
label: nasp_nasp.py
doc: "The Northern Arizona SNP Pipeline (NASP) is a tool for performing core genome
  SNP analysis.\n\nTool homepage: https://github.com/TGenNorth/nasp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nasp:1.2.1--py38hebad582_1
stdout: nasp_nasp.py.out
