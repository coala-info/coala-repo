cwlVersion: v1.2
class: CommandLineTool
baseCommand: miR_PREFeR.py
label: mir-prefer_miR_PREFeR.py
doc: "miR_PREFeR (miRNA PREdiction From small RNA-Seq data). Note: The provided text
  contains environment error messages rather than help documentation; therefore, no
  arguments could be extracted.\n\nTool homepage: https://github.com/hangelwen/miR-PREFeR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mir-prefer:0.24--py27_2
stdout: mir-prefer_miR_PREFeR.py.out
