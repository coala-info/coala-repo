cwlVersion: v1.2
class: CommandLineTool
baseCommand: peka_peka.py
label: peka_peka.py
doc: "Position-based Evaluation of Key Attributes (PEKA). Note: The provided input
  text was an error message and did not contain usage instructions or argument definitions.\n\
  \nTool homepage: https://github.com/ulelab/peka"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peka:1.0.2--pyhdfd78af_0
stdout: peka_peka.py.out
