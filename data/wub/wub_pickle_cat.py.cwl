cwlVersion: v1.2
class: CommandLineTool
baseCommand: pickle_cat.py
label: wub_pickle_cat.py
doc: "Pretty print the contents of a pickle file.\n\nTool homepage: https://github.com/nanoporetech/wub"
stdout: pickle_cat.txt
inputs:
  - id: pickle_file
    type: File
    doc: "Input pickle file."
    inputBinding:
      position: 100
outputs:
  - id: contents
    type: stdout
    doc: "Printed contents of the pickle file"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
