cwlVersion: v1.2
class: CommandLineTool
baseCommand: ptgaul_gunzip
label: ptgaul_gunzip
doc: "The provided text does not contain help information or usage instructions for
  the tool; it consists of container environment logs and a fatal error message regarding
  a SIF build failure.\n\nTool homepage: https://github.com/Bean061/ptgaul"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ptgaul:1.0.5--pyhdfd78af_1
stdout: ptgaul_gunzip.out
