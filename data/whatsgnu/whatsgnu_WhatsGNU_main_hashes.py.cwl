cwlVersion: v1.2
class: CommandLineTool
baseCommand: whatsgnu_WhatsGNU_main_hashes.py
label: whatsgnu_WhatsGNU_main_hashes.py
doc: "The provided text does not contain help information, but appears to be a log
  of a failed container build or execution. No arguments could be extracted.\n\nTool
  homepage: https://github.com/ahmedmagds/WhatsGNU"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/whatsgnu:1.5--hdfd78af_0
stdout: whatsgnu_WhatsGNU_main_hashes.py.out
