cwlVersion: v1.2
class: CommandLineTool
baseCommand: ruranges
label: ruranges
doc: "The provided text is a container build log and does not contain help information
  or usage instructions for the tool.\n\nTool homepage: https://github.com/pyranges/ruranges"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ruranges:0.0.15--py312h570fbca_0
stdout: ruranges.out
