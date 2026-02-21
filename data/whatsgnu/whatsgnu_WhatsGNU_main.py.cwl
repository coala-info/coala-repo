cwlVersion: v1.2
class: CommandLineTool
baseCommand: whatsgnu_WhatsGNU_main.py
label: whatsgnu_WhatsGNU_main.py
doc: "The provided text does not contain help information or a description of the
  tool; it appears to be a container build error log.\n\nTool homepage: https://github.com/ahmedmagds/WhatsGNU"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/whatsgnu:1.5--hdfd78af_0
stdout: whatsgnu_WhatsGNU_main.py.out
