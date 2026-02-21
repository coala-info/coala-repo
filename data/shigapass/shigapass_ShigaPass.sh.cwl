cwlVersion: v1.2
class: CommandLineTool
baseCommand: shigapass_ShigaPass.sh
label: shigapass_ShigaPass.sh
doc: "ShigaPass is a tool for the classification of Shiga toxin-producing Escherichia
  coli (STEC). (Note: The provided help text contains system error logs regarding
  a failed container build and does not list command-line arguments.)\n\nTool homepage:
  https://github.com/imanyass/ShigaPass/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shigapass:1.5.0--hdfd78af_0
stdout: shigapass_ShigaPass.sh.out
