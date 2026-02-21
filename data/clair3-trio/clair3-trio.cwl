cwlVersion: v1.2
class: CommandLineTool
baseCommand: clair3-trio
label: clair3-trio
doc: "Clair3-Trio is a variant caller for family trios. (Note: The provided input
  text consists of container runtime error logs regarding disk space and does not
  contain the tool's help documentation; therefore, no arguments could be extracted.)\n
  \nTool homepage: https://github.com/HKU-BAL/Clair3-Trio"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clair3-trio:0.7--py39hd649744_2
stdout: clair3-trio.out
