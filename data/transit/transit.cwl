cwlVersion: v1.2
class: CommandLineTool
baseCommand: transit
label: transit
doc: "The provided text is an error log indicating a system failure (no space left
  on device) during a container build process and does not contain help text or argument
  definitions for the 'transit' tool.\n\nTool homepage: http://github.com/mad-lab/transit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
stdout: transit.out
