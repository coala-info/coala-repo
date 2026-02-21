cwlVersion: v1.2
class: CommandLineTool
baseCommand: eklipse
label: eklipse
doc: "The provided text does not contain help information or a description of the
  tool; it contains container runtime error messages.\n\nTool homepage: https://github.com/dooguypapua/eKLIPse"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eklipse:1.8--hdfd78af_2
stdout: eklipse.out
