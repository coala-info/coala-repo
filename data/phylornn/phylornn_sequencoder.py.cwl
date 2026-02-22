cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylornn_sequencoder.py
label: phylornn_sequencoder.py
doc: "PhyloRNN sequence encoder (Note: The provided text contains system error logs
  regarding disk space and container image conversion rather than command-line help
  documentation.)\n\nTool homepage: https://github.com/phyloRNN/phyloRNN"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylornn:1.1--pyhdfd78af_0
stdout: phylornn_sequencoder.py.out
