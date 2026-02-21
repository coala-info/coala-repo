cwlVersion: v1.2
class: CommandLineTool
baseCommand: paralyzer
label: paralyzer
doc: "The provided text does not contain help information or usage instructions for
  the tool 'paralyzer'. It appears to be a log of a failed execution attempt within
  a container environment.\n\nTool homepage: https://github.com/D4Vinci/Palsy-Virus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paralyzer:1.5--2
stdout: paralyzer.out
