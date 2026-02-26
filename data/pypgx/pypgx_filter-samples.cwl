cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pypgx
  - filter-samples
label: pypgx_filter-samples
doc: "Filter Archive file for specified samples.\n\nTool homepage: https://github.com/sbslee/pypgx"
inputs:
  - id: input
    type: File
    doc: Input archive file.
    inputBinding:
      position: 1
  - id: samples
    type:
      type: array
      items: string
    doc: Specify which samples should be included for analysis by providing a 
      text file (.txt, .tsv, .csv, or .list) containing one sample per line. 
      Alternatively, you can provide a list of samples.
    inputBinding:
      position: 2
  - id: exclude
    type:
      - 'null'
      - boolean
    doc: Exclude specified samples.
    inputBinding:
      position: 103
      prefix: --exclude
outputs:
  - id: output
    type: File
    doc: Output archive file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
