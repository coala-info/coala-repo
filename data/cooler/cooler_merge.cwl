cwlVersion: v1.2
class: CommandLineTool
baseCommand: cooler merge
label: cooler_merge
doc: "Merge multiple coolers with identical axes.\n\nTool homepage: https://github.com/open2c/cooler"
inputs:
  - id: out_path
    type: File
    doc: Output file path or URI.
    inputBinding:
      position: 1
  - id: in_paths
    type:
      type: array
      items: File
    doc: Input file paths or URIs of coolers to merge.
    inputBinding:
      position: 2
  - id: append
    type:
      - 'null'
      - boolean
    doc: Pass this flag to append the output cooler to an existing file instead 
      of overwriting the file.
    inputBinding:
      position: 103
      prefix: --append
  - id: chunksize
    type:
      - 'null'
      - int
    doc: Size of the merge buffer in number of pixel table rows.
    default: 20000000
    inputBinding:
      position: 103
      prefix: --chunksize
  - id: field
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify the names of value columns to merge as '<name>'. Repeat the 
      `--field` option for each one. Use '<name>,dtype=<dtype>' to specify the 
      dtype. Include ',agg=<agg>' to specify an aggregation function different 
      from 'sum'.
    inputBinding:
      position: 103
      prefix: --field
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
stdout: cooler_merge.out
