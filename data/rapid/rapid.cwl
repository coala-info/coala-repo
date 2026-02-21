cwlVersion: v1.2
class: CommandLineTool
baseCommand: rapid
label: rapid
doc: "The provided text does not contain help information or a description for the
  tool 'rapid'. It appears to be a log of a failed container build process.\n\nTool
  homepage: https://github.com/SchulzLab/RAPID"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rapid:1.0--r351_0
stdout: rapid.out
