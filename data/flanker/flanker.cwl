cwlVersion: v1.2
class: CommandLineTool
baseCommand: flanker
label: flanker
doc: "A tool for the analysis of flanking sequences around genes of interest.\n\n\
  Tool homepage: https://github.com/wtmatlock/flanker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flanker:0.1.5--py_0
stdout: flanker.out
