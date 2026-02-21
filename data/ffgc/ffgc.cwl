cwlVersion: v1.2
class: CommandLineTool
baseCommand: ffgc
label: ffgc
doc: "Fast Functional Gene Cluster (Note: The provided text contains container runtime
  error messages and does not include the tool's help documentation or usage instructions.)\n
  \nTool homepage: https://gitlab.ub.uni-bielefeld.de/gi/FFGC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ffgc:2.4.2--py312h7e72e81_1
stdout: ffgc.out
