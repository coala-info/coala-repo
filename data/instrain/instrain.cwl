cwlVersion: v1.2
class: CommandLineTool
baseCommand: instrain
label: instrain
doc: "The provided text does not contain help information or a description of the
  tool; it contains system log messages and a fatal error regarding container execution.\n
  \nTool homepage: https://github.com/MrOlm/inStrain"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/instrain:1.10.0--pyhdfd78af_0
stdout: instrain.out
