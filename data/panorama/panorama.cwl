cwlVersion: v1.2
class: CommandLineTool
baseCommand: panorama
label: panorama
doc: "The provided text is a container build log and does not contain help information
  or argument definitions for the 'panorama' tool.\n\nTool homepage: https://github.com/labgem/panorama"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panorama:1.0.0--pyhdfd78af_0
stdout: panorama.out
