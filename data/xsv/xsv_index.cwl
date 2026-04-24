cwlVersion: v1.2
class: CommandLineTool
baseCommand: xsv_index
label: xsv_index
doc: "Creates an index of the given CSV data, which can make other operations like
  slicing, splitting and gathering statistics much faster.\n\nTool homepage: https://github.com/BurntSushi/xsv"
inputs:
  - id: input
    type: File
    doc: Path to the input CSV file
    inputBinding:
      position: 1
  - id: delimiter
    type:
      - 'null'
      - string
    doc: The field delimiter for reading CSV data. Must be a single character.
    inputBinding:
      position: 102
      prefix: --delimiter
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write index to <file> instead of <input>.idx. Generally, this is not 
      currently useful because the only way to use an index is if it is 
      specially named <input>.idx.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xsv:0.10.3--0
