cwlVersion: v1.2
class: CommandLineTool
baseCommand: qsignature
label: qsignature
doc: The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container image build/fetch process.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qsignature:0.1pre--3
stdout: qsignature.out
