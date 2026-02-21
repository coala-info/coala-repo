cwlVersion: v1.2
class: CommandLineTool
baseCommand: sanitizeme
label: sanitizeme
doc: "A tool for sanitizing data (Note: The provided text contains container build
  logs and error messages rather than standard help documentation; no arguments could
  be extracted from the input).\n\nTool homepage: https://github.com/jiangweiyao/SanitizeMe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sanitizeme:1.1--hdfd78af_2
stdout: sanitizeme.out
