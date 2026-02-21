cwlVersion: v1.2
class: CommandLineTool
baseCommand: hamip
label: hamip
doc: "Haplotype-aware Mutation Identification Pipeline (Note: The provided help text
  contains only system error logs and does not list specific arguments or usage instructions).\n
  \nTool homepage: https://github.com/lijinbio/HaMiP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hamip:0.0.3.2--py_0
stdout: hamip.out
