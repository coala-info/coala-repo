cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - intrahost.py
  - tabfile_rename
label: viral-ngs_intrahost_tabfile_rename
doc: "Take input tab file and copy to an output file while changing the values in a specific column based on a mapping file. The first line will pass through untouched (it is assumed to be a header).\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_file
    type: File
    doc: "Input flat file"
    inputBinding:
      position: 1
  - id: map_file
    type: File
    doc: "Map file. Two-column headerless file that maps input values to output values. This script will error if there are values in inFile that do not exist in mapFile."
    inputBinding:
      position: 2
  - id: out_file
    type: string
    doc: "Output flat file"
    inputBinding:
      position: 3
  - id: col_idx
    type:
      - 'null'
      - int
    doc: "Which column number to replace (0-based index). [default: 0]"
    inputBinding:
      position: 20
      prefix: --col_idx
  - id: loglevel
    type:
      - 'null'
      - type: enum
        symbols:
          - DEBUG
          - INFO
          - WARNING
          - ERROR
          - CRITICAL
          - EXCEPTION
    doc: "Verboseness of output. [default: DEBUG]"
    inputBinding:
      position: 20
      prefix: --loglevel
outputs:
  - id: out_file_file
    type: File
    doc: "Output file written to out_file"
    outputBinding:
      glob: $(inputs.out_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
