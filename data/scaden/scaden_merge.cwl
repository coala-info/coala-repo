cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scaden
  - merge
label: scaden_merge
doc: "Merge simulated datasets into on training dataset\n\nTool homepage: https://github.com/KevinMenden/scaden"
inputs:
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing simulated datasets (in .h5ad format)
    inputBinding:
      position: 101
      prefix: --data
  - id: filenames
    type:
      - 'null'
      - type: array
        items: File
    doc: List of .h5ad files to merge (joined with commas on the command line)
    inputBinding:
      position: 101
      prefix: --files
      itemSeparator: ','
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Prefix of output file
    inputBinding:
      position: 101
      prefix: --prefix
outputs:
  - id: merged_file
    type: File
    doc: Merged training dataset (<prefix>.h5ad)
    outputBinding:
      glob: $((inputs.output_prefix || 'data') + '.h5ad')
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scaden:1.1.2--pyhdfd78af_0
