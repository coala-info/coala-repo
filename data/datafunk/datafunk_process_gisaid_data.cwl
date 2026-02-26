cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - datafunk
  - process_gisaid_data
label: datafunk_process_gisaid_data
doc: "Gisaid json (+ metadata) -> (new) gisaid.fasta + metadata\n\nTool homepage:
  https://github.com/cov-ert/datafunk"
inputs:
  - id: exclude_file
    type:
      - 'null'
      - type: array
        items: File
    doc: "A file that contains (anywhere) EPI_ISL_###### IDs to\n                \
      \        exclude (can provide many files, e.g. -e FILE1 -e\n               \
      \         FILE2 ...)"
    inputBinding:
      position: 101
      prefix: --exclude-file
  - id: exclude_uk
    type:
      - 'null'
      - boolean
    doc: "Excludes GISAID entries from England, Ireland,\n                       \
      \ Scotland or Wales from being written to fasta (default\n                 \
      \       is to include them)"
    inputBinding:
      position: 101
      prefix: --exclude-uk
  - id: exclude_undated
    type:
      - 'null'
      - boolean
    doc: "Excludes GISAID entries with an incomplete date from\n                 \
      \       being written to fasta (default is to include them)"
    inputBinding:
      position: 101
      prefix: --exclude-undated
  - id: include_omitted_file
    type:
      - 'null'
      - boolean
    doc: "Write GISAID entries excluded in --exclude-file FILE\n                 \
      \       to fasta (default is to exclude them)"
    inputBinding:
      position: 101
      prefix: --include-omitted-file
  - id: include_subsampled
    type:
      - 'null'
      - boolean
    doc: "Write GISAID entries previously flagged as duplicated\n                \
      \        to fasta (default is to exclude them)"
    inputBinding:
      position: 101
      prefix: --include-subsampled
  - id: input_json
    type: File
    doc: Gisaid json data
    inputBinding:
      position: 101
      prefix: --input-json
  - id: input_metadata
    type: File
    doc: previous metadata (can be 'False')
    inputBinding:
      position: 101
      prefix: --input-metadata
outputs:
  - id: output_fasta
    type:
      - 'null'
      - File
    doc: fasta format file to write.
    outputBinding:
      glob: $(inputs.output_fasta)
  - id: output_metadata
    type:
      - 'null'
      - File
    doc: metadata file to write.
    outputBinding:
      glob: $(inputs.output_metadata)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
