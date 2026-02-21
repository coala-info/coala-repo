cwlVersion: v1.2
class: CommandLineTool
baseCommand: referee_build
label: referee_build
doc: "The provided text is a log of a container build process failure and does not
  contain usage information or command-line arguments.\n\nTool homepage: https://github.com/gwct/referee"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/referee:1.2--hdfd78af_0
stdout: referee_build.out
