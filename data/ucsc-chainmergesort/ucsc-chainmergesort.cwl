cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainMergeSort
label: ucsc-chainmergesort
doc: "Combine multiple sorted chain files into one larger sorted file.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: One or more sorted chain files to be merged.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chainmergesort:482--h0b57e2e_0
stdout: ucsc-chainmergesort.out
