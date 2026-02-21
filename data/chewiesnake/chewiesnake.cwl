cwlVersion: v1.2
class: CommandLineTool
baseCommand: chewiesnake
label: chewiesnake
doc: "The provided text does not contain help information or usage instructions for
  chewiesnake. It contains system logs and a fatal error message regarding a container
  build failure (no space left on device).\n\nTool homepage: https://gitlab.com/bfr_bioinformatics/chewieSnake"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chewiesnake:3.0.0--hdfd78af_2
stdout: chewiesnake.out
