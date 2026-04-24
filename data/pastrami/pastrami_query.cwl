cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pastrami.py
  - query
label: pastrami_query
doc: "Query a reference pickle with TPED/TFAM input files to generate copying matrices.\n
  \nTool homepage: https://github.com/healthdisparities/pastrami"
inputs:
  - id: query_prefix
    type: string
    doc: Prefix for the query TPED/TFAM input files
    inputBinding:
      position: 101
      prefix: --query-prefix
  - id: reference_pickle
    type:
      - 'null'
      - File
    doc: A pre-made reference pickle
    inputBinding:
      position: 101
      prefix: --reference-pickle
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of concurrent threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print program progress information on screen
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: query_out
    type:
      - 'null'
      - File
    doc: The query copying matrix output
    outputBinding:
      glob: $(inputs.query_out)
  - id: combined_out
    type:
      - 'null'
      - File
    doc: The combined reference/query copying matrix output
    outputBinding:
      glob: $(inputs.combined_out)
  - id: log_file
    type:
      - 'null'
      - File
    doc: File containing log information
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pastrami:1.0.1--pyh67a8953_0
