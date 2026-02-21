cwlVersion: v1.2
class: CommandLineTool
baseCommand: httpretty
label: httpretty
doc: "The provided text does not contain help information or documentation for the
  tool; it contains system error logs related to a container image build failure.\n
  \nTool homepage: https://github.com/gabrielfalcao/HTTPretty"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/httpretty:0.8.10--py36_0
stdout: httpretty.out
