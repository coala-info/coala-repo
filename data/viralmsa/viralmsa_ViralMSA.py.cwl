cwlVersion: v1.2
class: CommandLineTool
baseCommand: ViralMSA.py
label: viralmsa_ViralMSA.py
doc: "Viral Multiple Sequence Alignment tool. Note: The provided help text contains
  only container runtime error logs and does not list specific command-line arguments.\n
  \nTool homepage: https://github.com/niemasd/ViralMSA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viralmsa:1.1.46--hdfd78af_0
stdout: viralmsa_ViralMSA.py.out
