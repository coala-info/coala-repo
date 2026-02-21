cwlVersion: v1.2
class: CommandLineTool
baseCommand: meta-sparse
label: meta-sparse
doc: "The provided text contains container runtime logs and error messages rather
  than the tool's help documentation. As a result, no arguments or functional descriptions
  could be extracted.\n\nTool homepage: https://github.com/zheminzhou/SPARSE/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meta-sparse:0.1.12--py27h24bf2e0_0
stdout: meta-sparse.out
