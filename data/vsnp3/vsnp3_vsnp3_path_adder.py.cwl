cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp3_vsnp3_path_adder.py
label: vsnp3_vsnp3_path_adder.py
doc: "The provided text does not contain help information for the tool; it appears
  to be a log of a failed container image build/fetch process.\n\nTool homepage: https://github.com/USDA-VS/vsnp3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp3:3.32--hdfd78af_0
stdout: vsnp3_vsnp3_path_adder.py.out
