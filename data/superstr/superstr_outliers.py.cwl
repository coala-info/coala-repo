cwlVersion: v1.2
class: CommandLineTool
baseCommand: superstr_outliers.py
label: superstr_outliers.py
doc: "The provided text does not contain help information or a description of the
  tool; it contains container execution error logs.\n\nTool homepage: https://github.com/bahlolab/superSTR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/superstr:1.0.1--h86fab0c_5
stdout: superstr_outliers.py.out
