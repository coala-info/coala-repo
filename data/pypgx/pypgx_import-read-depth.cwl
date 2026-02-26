cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pypgx
  - import-read-depth
label: pypgx_import-read-depth
doc: "Import read depth data for target gene.\n\nTool homepage: https://github.com/sbslee/pypgx"
inputs:
  - id: gene
    type: string
    doc: Target gene.
    inputBinding:
      position: 1
  - id: depth_of_coverage
    type: File
    doc: Input archive file with the semantic type CovFrame[DepthOfCoverage].
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
  - id: samples
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify which samples should be included for analysis by providing a 
      text file (.txt, .tsv, .csv, or .list) containing one sample per line. 
      Alternatively, you can provide a list of samples.
    inputBinding:
      position: 103
      prefix: --samples
outputs:
  - id: read_depth
    type: File
    doc: Output archive file with the semantic type CovFrame[ReadDepth].
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
