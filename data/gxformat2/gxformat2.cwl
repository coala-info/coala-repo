cwlVersion: v1.2
class: CommandLineTool
baseCommand: gxformat2
label: gxformat2
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container runtime failure (no space left
  on device).\n\nTool homepage: https://github.com/jmchilton/gxformat2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gxformat2:0.21.0--pyhdfd78af_0
stdout: gxformat2.out
