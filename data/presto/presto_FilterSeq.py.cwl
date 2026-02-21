cwlVersion: v1.2
class: CommandLineTool
baseCommand: presto_FilterSeq.py
label: presto_FilterSeq.py
doc: "The provided text does not contain help information for the tool. It contains
  container runtime log messages and a fatal error regarding an OCI image build failure.\n
  \nTool homepage: http://presto.readthedocs.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/presto:0.7.8--pyhdfd78af_0
stdout: presto_FilterSeq.py.out
