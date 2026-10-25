cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraFetch
label: ucsc-parafetch
doc: "try to fetch url with multiple connections. If outPath is not given, the output
  file name is parsed from the URL.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: num_connections
    type: int
    doc: N, the number of connections to use
    inputBinding:
      position: 1
  - id: num_retries
    type: int
    doc: R, the number of retries
    inputBinding:
      position: 2
  - id: url
    type: string
    doc: The URL of the file to fetch
    inputBinding:
      position: 3
  - id: out_path
    type: string
    doc: Output file path (outPath). Always given here so that the output can be collected
    inputBinding:
      position: 4
  - id: newer
    type:
      - 'null'
      - boolean
    doc: only download a file if it is newer than the version we already have.
    inputBinding:
      position: 0
      prefix: -newer
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Show progress of download.
    inputBinding:
      position: 0
      prefix: -progress
outputs:
  - id: output_file
    type: File
    doc: The downloaded file
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-parafetch:482--h0b57e2e_0
