cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainMergeSort
label: ucsc-chainstitchid_chainMergeSort
doc: "Merge and sort UCSC chain files. (Note: The provided help text contained container
  runtime errors and did not list specific arguments.)\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chainstitchid:482--h0b57e2e_0
stdout: ucsc-chainstitchid_chainMergeSort.out
