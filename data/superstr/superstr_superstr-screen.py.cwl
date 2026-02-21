cwlVersion: v1.2
class: CommandLineTool
baseCommand: superstr_superstr-screen.py
label: superstr_superstr-screen.py
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build or image retrieval process.\n\nTool homepage:
  https://github.com/bahlolab/superSTR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/superstr:1.0.1--h86fab0c_5
stdout: superstr_superstr-screen.py.out
