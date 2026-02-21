cwlVersion: v1.2
class: CommandLineTool
baseCommand: smncopynumbercaller_smn_charts.py
label: smncopynumbercaller_smn_charts.py
doc: "A tool for generating charts related to SMN copy number calling. (Note: The
  provided text contains container runtime error logs and does not include help documentation
  or argument definitions.)\n\nTool homepage: https://github.com/Illumina/SMNCopyNumberCaller"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smncopynumbercaller:1.1.2--py312h7e72e81_1
stdout: smncopynumbercaller_smn_charts.py.out
