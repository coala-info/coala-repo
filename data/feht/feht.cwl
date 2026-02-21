cwlVersion: v1.2
class: CommandLineTool
baseCommand: feht
label: feht
doc: "A tool for performing Fisher's Exact test on Haplotype Tables (Note: The provided
  help text contains only container runtime error messages and no usage information).\n
  \nTool homepage: https://github.com/chadlaing/feht/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/feht:1.1.0--0
stdout: feht.out
