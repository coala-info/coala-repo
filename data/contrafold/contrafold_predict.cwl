cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - contrafold
  - predict
label: contrafold_predict
doc: "Predict RNA secondary structures using the CONTRAfold algorithm.\n\nTool homepage:
  http://contra.stanford.edu/contrafold/faq.html"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: One or more input filenames for structure prediction.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/contrafold:2.02--h9948957_4
stdout: contrafold_predict.out
