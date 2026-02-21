cwlVersion: v1.2
class: CommandLineTool
baseCommand: stringmeup
label: stringmeup
doc: "No description available from the provided log text.\n\nTool homepage: https://github.com/danisven/StringMeUp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stringmeup:0.1.5--pyhdfd78af_0
stdout: stringmeup.out
