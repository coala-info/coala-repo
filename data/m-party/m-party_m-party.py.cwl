cwlVersion: v1.2
class: CommandLineTool
baseCommand: m-party.py
label: m-party_m-party.py
doc: "A tool for metagenomic analysis (Note: The provided help text contains only
  system error messages and no usage information).\n\nTool homepage: https://github.com/ozefreitas/M-PARTY"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/m-party:0.2.2--hdfd78af_0
stdout: m-party_m-party.py.out
