cwlVersion: v1.2
class: CommandLineTool
baseCommand: presto_AssemblePairs.py
label: presto_AssemblePairs.py
doc: "The provided text does not contain help information for the tool. It appears
  to be a container execution error log.\n\nTool homepage: http://presto.readthedocs.io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/presto:0.7.8--pyhdfd78af_0
stdout: presto_AssemblePairs.py.out
