cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraFetch
label: ucsc-parafetch
doc: "Fetch a file using multiple connections in parallel.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: num_connections
    type: int
    doc: Number of connections to use for the download
    inputBinding:
      position: 1
  - id: url
    type: string
    doc: The URL of the file to fetch
    inputBinding:
      position: 2
outputs:
  - id: output_path
    type:
      - 'null'
      - File
    doc: The path to the output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-parafetch:482--h0b57e2e_0
