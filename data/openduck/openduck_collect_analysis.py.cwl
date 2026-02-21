cwlVersion: v1.2
class: CommandLineTool
baseCommand: openduck_collect_analysis.py
label: openduck_collect_analysis.py
doc: "A tool to collect analysis results from OpenDuck. Note: The provided text contains
  system error logs and does not include usage information or argument definitions.\n
  \nTool homepage: https://github.com/galaxycomputationalchemistry/duck"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/openduck:0.1.2--py_0
stdout: openduck_collect_analysis.py.out
