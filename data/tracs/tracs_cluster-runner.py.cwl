cwlVersion: v1.2
class: CommandLineTool
baseCommand: tracs_cluster-runner.py
label: tracs_cluster-runner.py
doc: "Cluster runner for TRACS. (Note: The provided text contains container execution
  error logs and does not include usage instructions or argument definitions; therefore,
  no arguments could be extracted.)\n\nTool homepage: https://github.com/gtonkinhill/tracs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tracs:1.0.1--py312h43eeafb_1
stdout: tracs_cluster-runner.py.out
