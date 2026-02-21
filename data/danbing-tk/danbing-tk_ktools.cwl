cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - danbing-tk
  - ktools
label: danbing-tk_ktools
doc: "The provided text is an error log and does not contain a description of the
  tool.\n\nTool homepage: https://github.com/ChaissonLab/danbing-tk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/danbing-tk:1.3.2.5--h9948957_0
stdout: danbing-tk_ktools.out
