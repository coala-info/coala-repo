cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alleyoop
  - merge
label: slamdunk_alleyoop_merge
doc: "Merge T->C rates from multiple sample in one TSV file\n\nTool homepage: http://t-neumann.github.io/slamdunk"
inputs:
  - id: count_files
    type:
      type: array
      items: File
    doc: 'tCount files'
    inputBinding:
      position: 100
  - id: column
    type: ['null', string]
    doc: 'Column or expression used to summarize files. (default: TcReadCount / ReadCount)'
    inputBinding:
      position: 1
      prefix: --column
  - id: column_name
    type: ['null', string]
    doc: 'Index of meta data field to use as column name. (default: 2)'
    inputBinding:
      position: 1
      prefix: --columnname
  - id: output_file
    type: string
    default: merge_out.tsv
    doc: Output file
    inputBinding:
      position: 1
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slamdunk:0.4.3--py_0
