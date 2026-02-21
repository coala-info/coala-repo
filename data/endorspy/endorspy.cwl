cwlVersion: v1.2
class: CommandLineTool
baseCommand: endorspy
label: endorspy
doc: "Endogenous Retrovirus (ERV) detection and analysis tool. (Note: The provided
  help text contains only system error logs and does not list specific command-line
  arguments.)\n\nTool homepage: https://github.com/aidaanva/endorS.py"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/endorspy:1.4--hdfd78af_0
stdout: endorspy.out
