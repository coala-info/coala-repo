cwlVersion: v1.2
class: CommandLineTool
baseCommand: pymummer
label: pymummer
doc: "The provided text does not contain help information or documentation for the
  tool. It consists of system logs and a fatal error message regarding a container
  build failure.\n\nTool homepage: https://github.com/sanger-pathogens/pymummer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymummer:0.12.0--pyhdfd78af_0
stdout: pymummer.out
