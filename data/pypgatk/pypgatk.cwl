cwlVersion: v1.2
class: CommandLineTool
baseCommand: pypgatk
label: pypgatk
doc: "The provided text does not contain a description of the tool; it is a log of
  a failed container build process.\n\nTool homepage: http://github.com/bigbio/py-pgatk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgatk:0.0.24--pyhdfd78af_0
stdout: pypgatk.out
