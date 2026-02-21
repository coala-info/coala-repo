cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyhashxx
label: pyhashxx
doc: "The provided text contains container engine logs and a fatal error message rather
  than the tool's help documentation. No command-line arguments or descriptions could
  be extracted.\n\nTool homepage: https://github.com/ewencp/pyhashxx"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyhashxx:0.1.3--py34_0
stdout: pyhashxx.out
