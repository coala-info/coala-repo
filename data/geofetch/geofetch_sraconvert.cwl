cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - geofetch
  - sraconvert
label: geofetch_sraconvert
doc: "A tool for converting SRA data (Note: The provided help text contains only system
  error logs and no usage information).\n\nTool homepage: https://github.com/pepkit/geofetch/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/geofetch:0.12.10--pyhdfd78af_0
stdout: geofetch_sraconvert.out
