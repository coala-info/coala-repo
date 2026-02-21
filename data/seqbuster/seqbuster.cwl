cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqbuster
label: seqbuster
doc: "SeqBuster is a suite of tools for the analysis of small RNA datasets, particularly
  focused on miRNA and isomiR identification.\n\nTool homepage: https://github.com/lpantano/seqbuster"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqbuster:3.5--0
stdout: seqbuster.out
