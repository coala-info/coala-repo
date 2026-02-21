cwlVersion: v1.2
class: CommandLineTool
baseCommand: geofetch
label: geofetch
doc: "The provided text is an error log indicating a failure to build or run the geofetch
  container due to insufficient disk space; it does not contain help text or argument
  definitions.\n\nTool homepage: https://github.com/pepkit/geofetch/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/geofetch:0.12.10--pyhdfd78af_0
stdout: geofetch.out
