cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pastrami.py
  - query
label: pastrami_query
doc: "Query reference set\n\nTool homepage: https://github.com/healthdisparities/pastrami"
inputs:
  - id: reference_pickle
    type:
      - 'null'
      - File
    doc: "A pre-made reference pickle"
    inputBinding:
      position: 101
      prefix: --reference-pickle
  - id: query_files
    type:
      type: array
      items: File
    doc: "TPED and TFAM files of the query individuals (they are staged in the working directory)"
  - id: query_prefix
    type:
      - 'null'
      - string
    doc: "Prefix for the query TPED/TFAM input files"
    inputBinding:
      position: 101
      prefix: --query-prefix
  - id: log_file_path
    type:
      - 'null'
      - string
    doc: "File containing log information (default: run.log)"
    inputBinding:
      position: 102
      prefix: --log-file
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of concurrent threads (default: 4)"
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print program progress information on screen"
    inputBinding:
      position: 101
      prefix: --verbose
  - id: query_out_path
    type: string
    doc: "The query copying matrix output"
    inputBinding:
      position: 103
      prefix: --query-out
  - id: combined_out_path
    type: string
    doc: "The combined reference/query copying matrix output"
    inputBinding:
      position: 104
      prefix: --combined-out
outputs:
  - id: query_out
    type: File
    doc: "The query copying matrix"
    outputBinding:
      glob: $(inputs.query_out_path)
  - id: combined_out
    type: File
    doc: "The combined reference/query copying matrix"
    outputBinding:
      glob: $(inputs.combined_out_path)
  - id: log_file
    type:
      - 'null'
      - File
    doc: "File containing log information"
    outputBinding:
      glob: $(inputs.log_file_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.query_files)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pastrami:1.0.1--pyh67a8953_0
