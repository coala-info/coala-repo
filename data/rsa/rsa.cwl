cwlVersion: v1.2
class: CommandLineTool
baseCommand: rsa
label: rsa
doc: "The provided text is a container build log and does not contain CLI help information
  or argument definitions.\n\nTool homepage: https://github.com/RsaCtfTool/RsaCtfTool"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsa:3.1.4--py35_0
stdout: rsa.out
