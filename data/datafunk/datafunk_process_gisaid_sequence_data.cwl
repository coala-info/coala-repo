cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - datafunk
  - process_gisaid_sequence_data
label: datafunk_process_gisaid_sequence_data
doc: "Process raw sequence data in fasta or json format\n\nTool homepage: https://github.com/cov-ert/datafunk"
inputs:
  - id: exclude
    type:
      - 'null'
      - type: array
        items: File
    doc: A file that contains (anywhere) EPI_ISL_###### IDs to exclude (can 
      provide many files, e.g. -e FILE1 -e FILE2 ...)
    inputBinding:
      position: 101
      prefix: --exclude
  - id: exclude_uk
    type:
      - 'null'
      - boolean
    doc: Removes all GISAID entries with containing England, Ireland, Scotland 
      or Wales
    inputBinding:
      position: 101
      prefix: --exclude-uk
  - id: exclude_undated
    type:
      - 'null'
      - boolean
    doc: Removes all GISAID entries with an incomplete date
    inputBinding:
      position: 101
      prefix: --exclude-undated
  - id: input
    type: File
    doc: Sequence data in FASTA/json format
    inputBinding:
      position: 101
      prefix: --input
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: Print to stdout
    inputBinding:
      position: 101
      prefix: --stdout
outputs:
  - id: output_fasta
    type:
      - 'null'
      - File
    doc: FASTA format file to write, print to stdout if unspecified
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
