cwlVersion: v1.2
class: CommandLineTool
baseCommand: contrafold_train
label: contrafold_train
doc: "Train CONTRAfold models using provided sequence and structure data.\n\nTool
  homepage: http://contra.stanford.edu/contrafold/faq.html"
inputs:
  - id: filenames
    type:
      type: array
      items: File
    doc: Input filenames for training
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/contrafold:2.02--h9948957_4
stdout: contrafold_train.out
