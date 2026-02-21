cwlVersion: v1.2
class: CommandLineTool
baseCommand: ShortStack
label: shortstack
doc: "The provided text does not contain help information or a description of the
  tool; it contains system logs and a fatal error message regarding a container build
  failure.\n\nTool homepage: https://github.com/MikeAxtell/ShortStack"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shortstack:4.1.2--hdfd78af_0
stdout: shortstack.out
