cwlVersion: v1.2
class: CommandLineTool
baseCommand: presto_MaskPrimers.py
label: presto_MaskPrimers.py
doc: "The provided text does not contain help information for presto_MaskPrimers.py,
  but rather an error message regarding a container image build failure.\n\nTool homepage:
  http://presto.readthedocs.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/presto:0.7.8--pyhdfd78af_0
stdout: presto_MaskPrimers.py.out
