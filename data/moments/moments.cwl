cwlVersion: v1.2
class: CommandLineTool
baseCommand: moments
label: moments
doc: "The provided text does not contain help information or usage instructions. It
  is an error log indicating a failure to build or pull a container image due to insufficient
  disk space.\n\nTool homepage: https://bitbucket.org/simon-gravel/moments"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moments:1.5.0--py310h20b60a1_0
stdout: moments.out
