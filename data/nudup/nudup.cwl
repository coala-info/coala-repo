cwlVersion: v1.2
class: CommandLineTool
baseCommand: nudup
label: nudup
doc: "The provided text is a system error message regarding a container build failure
  and does not contain help or usage information for the tool 'nudup'.\n\nTool homepage:
  http://nugentechnologies.github.io/nudup/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nudup:2.3.3--py27_0
stdout: nudup.out
