cwlVersion: v1.2
class: CommandLineTool
baseCommand: prophane_prophane.py
label: prophane_prophane.py
doc: "The provided text does not contain help information or usage instructions for
  prophane_prophane.py. It contains log messages related to a failed Singularity/Apptainer
  image build process.\n\nTool homepage: https://gitlab.com/s.fuchs/prophane/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prophane:6.2.6--hdfd78af_0
stdout: prophane_prophane.py.out
