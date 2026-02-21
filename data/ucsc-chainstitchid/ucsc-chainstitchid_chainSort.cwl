cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainSort
label: ucsc-chainstitchid_chainSort
doc: "Sort chain files. (Note: The provided input text contains container runtime
  error messages rather than the tool's help documentation; therefore, no arguments
  could be extracted.)\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chainstitchid:482--h0b57e2e_0
stdout: ucsc-chainstitchid_chainSort.out
