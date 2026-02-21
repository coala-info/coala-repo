cwlVersion: v1.2
class: CommandLineTool
baseCommand: sipros_sipros_ensemble_filtering.py
label: sipros_sipros_ensemble_filtering.py
doc: "The provided text does not contain help information for the tool. It contains
  system logs and a fatal error regarding a container image build failure.\n\nTool
  homepage: https://github.com/thepanlab/Sipros4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sipros:5.0.1--hdfd78af_1
stdout: sipros_sipros_ensemble_filtering.py.out
