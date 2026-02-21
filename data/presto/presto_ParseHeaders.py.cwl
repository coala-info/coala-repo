cwlVersion: v1.2
class: CommandLineTool
baseCommand: presto_ParseHeaders.py
label: presto_ParseHeaders.py
doc: "A tool from the pRESTO suite for parsing and manipulating sequence headers.
  Note: The provided help text contains only container environment logs and a fatal
  error, so no arguments could be extracted.\n\nTool homepage: http://presto.readthedocs.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/presto:0.7.8--pyhdfd78af_0
stdout: presto_ParseHeaders.py.out
