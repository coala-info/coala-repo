cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedSort
label: ucsc-bedtogenepred_bedSort
doc: "The provided text does not contain help information as it is an error log reporting
  a failure to build or extract the container image (no space left on device).\n\n
  Tool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedtogenepred:482--h0b57e2e_0
stdout: ucsc-bedtogenepred_bedSort.out
