cwlVersion: v1.2
class: CommandLineTool
baseCommand: xsv_fixlengths
label: xsv_fixlengths
doc: "Transforms CSV data so that all records have the same length. The length is
  the length of the longest record in the data. Records with smaller lengths are padded
  with empty fields.\n\nThis requires two complete scans of the CSV data: one for
  determining the record size and one for the actual transform. Because of this, the
  input given must be a file and not stdin.\n\nAlternatively, if --length is set,
  then all records are forced to that length. This requires a single pass and can
  be done with stdin.\n\nTool homepage: https://github.com/BurntSushi/xsv"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: Input CSV file
    inputBinding:
      position: 1
  - id: delimiter
    type:
      - 'null'
      - string
    doc: "The field delimiter for reading CSV data.\n                           Must
      be a single character."
    default: ','
    inputBinding:
      position: 102
      prefix: --delimiter
  - id: length
    type:
      - 'null'
      - int
    doc: Forcefully set the length of each record. If a record is not the size 
      given, then it is truncated or expanded as appropriate.
    inputBinding:
      position: 102
      prefix: --length
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write output to <file> instead of stdout.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xsv:0.10.3--0
