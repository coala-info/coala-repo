cwlVersion: v1.2
class: CommandLineTool
baseCommand: smof
label: smof
doc: "The provided text does not contain help information or a description of the
  tool, as it consists of container runtime logs and a fatal error message.\n\nTool
  homepage: https://github.com/incertae-sedis/smof"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
stdout: smof.out
