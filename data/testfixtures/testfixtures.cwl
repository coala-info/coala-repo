cwlVersion: v1.2
class: CommandLineTool
baseCommand: testfixtures
label: testfixtures
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed container image build/fetch process.\n\n
  Tool homepage: https://github.com/go-testfixtures/testfixtures"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/testfixtures:4.8.0--py35_0
stdout: testfixtures.out
