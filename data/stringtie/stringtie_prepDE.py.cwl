cwlVersion: v1.2
class: CommandLineTool
baseCommand: stringtie_prepDE.py
label: stringtie_prepDE.py
doc: "A script to derive expression count matrices for genes and transcripts from
  StringTie output files.\n\nTool homepage: https://ccb.jhu.edu/software/stringtie"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stringtie:3.0.3--h29c0135_0
stdout: stringtie_prepDE.py.out
