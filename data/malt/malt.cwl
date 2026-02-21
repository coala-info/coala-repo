cwlVersion: v1.2
class: CommandLineTool
baseCommand: malt
label: malt
doc: "MALT (MEGAN Alignment Tool) is a tool for the sequence alignment of large datasets
  of DNA or protein reads to a database of reference sequences.\n\nTool homepage:
  http://ab.inf.uni-tuebingen.de/software/malt/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/malt:0.62--hdfd78af_0
stdout: malt.out
