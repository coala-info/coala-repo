cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - slamdunk
  - alleyoop
label: slamdunk_alleyoop
doc: "The provided text is a container execution error log and does not contain help
  information or argument definitions for slamdunk_alleyoop.\n\nTool homepage: http://t-neumann.github.io/slamdunk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slamdunk:0.4.3--py_0
stdout: slamdunk_alleyoop.out
