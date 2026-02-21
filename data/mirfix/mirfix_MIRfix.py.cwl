cwlVersion: v1.2
class: CommandLineTool
baseCommand: MIRfix.py
label: mirfix_MIRfix.py
doc: "MIRfix is a tool for analyzing and refining miRNA annotations. (Note: The provided
  help text contains a system error and does not list specific arguments.)\n\nTool
  homepage: https://github.com/Bierinformatik/MIRfix"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirfix:2.1.1--hdfd78af_0
stdout: mirfix_MIRfix.py.out
