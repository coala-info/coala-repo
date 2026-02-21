cwlVersion: v1.2
class: CommandLineTool
baseCommand: whatsgnu_WhatsGNU_database_customizer.py
label: whatsgnu_WhatsGNU_database_customizer.py
doc: "WhatsGNU database customizer (Note: The provided text contains build logs and
  error messages rather than help documentation. No arguments could be extracted.)\n
  \nTool homepage: https://github.com/ahmedmagds/WhatsGNU"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/whatsgnu:1.5--hdfd78af_0
stdout: whatsgnu_WhatsGNU_database_customizer.py.out
