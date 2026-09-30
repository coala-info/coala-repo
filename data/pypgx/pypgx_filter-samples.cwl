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
  - id: output
    type: string
    doc: Output archive file.
    inputBinding:
      position: 2
  - id: samples
    type:
      type: array
      items: string
    doc: Specify which samples should be included for analysis by providing a 
      text file (.txt, .tsv, .csv, or .list) containing one sample per line. 
      Alternatively, you can provide a list of samples.
    inputBinding:
      position: 3
  - id: exclude
    type:
      - 'null'
      - boolean
    doc: Exclude specified samples.
    inputBinding:
      position: 103
      prefix: --exclude
outputs:
  - id: out_output
    type: File
    doc: Output archive file.
    outputBinding:
      glob: '$(inputs.output)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
