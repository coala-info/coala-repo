cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mg-toolkit
  - sequence_search
label: mg-toolkit_sequence_search
doc: "Search non-redundant protein database using HMMER.\n\nTool homepage: https://github.com/EBI-metagenomics/emg-toolkit"
inputs:
  - id: search_method
    type: string
    doc: 'Search method to use: evalue or bitscore'
    inputBinding:
      position: 1
  - id: database
    type:
      - 'null'
      - string
    doc: Choose peptide database (full, all, or partial).
    default: full
    inputBinding:
      position: 102
      prefix: --database
  - id: sequence
    type:
      type: array
      items: File
    doc: Provide path to fasta file.
    inputBinding:
      position: 102
      prefix: --sequence
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: 'Output csv results file (default: <query_id>_sequence_search.csv)'
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mg-toolkit:0.10.4--pyhdfd78af_0
