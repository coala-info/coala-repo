cwlVersion: v1.2
class: CommandLineTool
baseCommand: sipros_refineProteinFDR.R
label: sipros_refineProteinFDR.R
doc: "The provided text does not contain help information or usage instructions for
  the tool; it is a log of a failed container image build process.\n\nTool homepage:
  https://github.com/thepanlab/Sipros4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sipros:5.0.1--hdfd78af_1
stdout: sipros_refineProteinFDR.R.out
