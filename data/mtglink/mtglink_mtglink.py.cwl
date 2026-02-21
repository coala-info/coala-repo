cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtglink_mtglink.py
label: mtglink_mtglink.py
doc: "MTG-Link: A tool for linking and scaffolding assembly graphs using long reads.\n
  \nTool homepage: https://github.com/anne-gcd/MTG-Link"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtglink:2.4.1--hdfd78af_0
stdout: mtglink_mtglink.py.out
