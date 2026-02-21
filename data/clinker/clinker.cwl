cwlVersion: v1.2
class: CommandLineTool
baseCommand: clinker
label: clinker
doc: "The provided text does not contain help information or usage instructions for
  the tool 'clinker'. It contains error logs related to a failed container image build
  (no space left on device).\n\nTool homepage: https://github.com/Oshlack/Clinker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clinker:1.33--hdfd78af_0
stdout: clinker.out
