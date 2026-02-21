cwlVersion: v1.2
class: CommandLineTool
baseCommand: gs-tama_tama_collapse.py
label: gs-tama_tama_collapse.py
doc: "TAMA collapse is a tool for collapsing redundant transcripts from Iso-Seq or
  other long-read RNA-seq data.\n\nTool homepage: https://github.com/sguizard/gs-tama"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
stdout: gs-tama_tama_collapse.py.out
