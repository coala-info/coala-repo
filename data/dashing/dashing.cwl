cwlVersion: v1.2
class: CommandLineTool
baseCommand: dashing
label: dashing
doc: "The provided text does not contain help information or usage instructions for
  the 'dashing' tool; it is a log of a failed container build process due to insufficient
  disk space.\n\nTool homepage: https://github.com/dnbaker/dashing"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dashing:1.0--h5b0a936_3
stdout: dashing.out
