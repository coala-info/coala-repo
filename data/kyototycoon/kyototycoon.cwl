cwlVersion: v1.2
class: CommandLineTool
baseCommand: kyototycoon
label: kyototycoon
doc: "Kyoto Tycoon is a lightweight database server. Note: The provided text is a
  container runtime error log and does not contain command-line argument definitions.\n
  \nTool homepage: https://github.com/alticelabs/kyoto"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kyototycoon:20170410--hbed32c3_5
stdout: kyototycoon.out
