cwlVersion: v1.2
class: CommandLineTool
baseCommand: msstitch split
label: msstitch_split
doc: "Split an input file based on a specified column or identifier.\n\nTool homepage:
  https://github.com/lehtiolab/msstitch"
inputs:
  - id: input_file
    type: File
    doc: Input file of {} format
    inputBinding:
      position: 101
      prefix: -i
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory to output in
    inputBinding:
      position: 101
      prefix: -d
  - id: split_column
    type: string
    doc: Either a column number to split a PSM table on, or "TD", "bioset" for 
      splitting on target/decoy or biological sample set columns (resulting from
      msstitch perco2psm or msstitch psmtable. First column is number 1.
    inputBinding:
      position: 101
      prefix: --splitcol
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msstitch:3.19--pyhdfd78af_0
