cwlVersion: v1.2
class: CommandLineTool
baseCommand: zol
label: zol_zol-suite
doc: "A tool for comparative genomics and pangenomics analysis (Note: The provided
  text contains system logs and build errors rather than CLI help documentation; therefore,
  no arguments could be extracted).\n\nTool homepage: https://github.com/Kalan-Lab/zol"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zol:1.6.17--py312hf731ba3_1
stdout: zol_zol-suite.out
