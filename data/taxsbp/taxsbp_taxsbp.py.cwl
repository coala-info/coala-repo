cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxsbp.py
label: taxsbp_taxsbp.py
doc: "The provided text does not contain help information for the tool. It contains
  system logs and a fatal error related to a container image build failure.\n\nTool
  homepage: https://github.com/pirovc/taxsbp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxsbp:1.1.1--py_0
stdout: taxsbp_taxsbp.py.out
