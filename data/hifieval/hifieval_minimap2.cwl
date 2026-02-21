cwlVersion: v1.2
class: CommandLineTool
baseCommand: hifieval_minimap2
label: hifieval_minimap2
doc: "The provided text does not contain help information or usage instructions. It
  contains system log messages and a fatal error regarding container image conversion
  (no space left on device).\n\nTool homepage: https://github.com/magspho/hifieval"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hifieval:0.4.0--pyh7cba7a3_0
stdout: hifieval_minimap2.out
