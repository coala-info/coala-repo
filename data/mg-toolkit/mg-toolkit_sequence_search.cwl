cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mg-toolkit
  - sequence_search
label: mg-toolkit_sequence_search
doc: "Search non-redundant protein database using HMMER.\n\nTool homepage: https://github.com/EBI-metagenomics/emg-toolkit"
inputs:
  - id: sequence
    type:
      type: array
      items: File
    doc: Provide path to fasta file.
    inputBinding:
      position: 101
      prefix: --sequence
  - id: output_path
    type: string
    default: sequence_search.csv
    doc: 'Output csv results file (default: <query_id>_sequence_search.csv)'
    inputBinding:
      position: 102
      prefix: --output
  - id: database
    type:
      - 'null'
      - string
    doc: Choose peptide database (full, all or partial; default full).
    inputBinding:
      position: 103
      prefix: --database
  - id: search_method
    type: string
    doc: 'Threshold type: evalue or bitscore'
    inputBinding:
      position: 200
  - id: seq_evalue_threshold
    type:
      - 'null'
      - float
    doc: Sequence E-value threshold (evalue method; 0 < x <= 10, default 0.01).
    inputBinding:
      position: 201
      prefix: --seq-evalue-threshold
  - id: hit_evalue_threshold
    type:
      - 'null'
      - float
    doc: Hit E-value threshold (evalue method; 0 < x <= 10, default 0.03).
    inputBinding:
      position: 201
      prefix: --hit-evalue-threshold
  - id: report_seq_evalue_threshold
    type:
      - 'null'
      - float
    doc: Sequence E-value threshold for reporting (evalue method, default 1).
    inputBinding:
      position: 201
      prefix: --report-seq-evalue-threshold
  - id: report_hit_evalue_threshold
    type:
      - 'null'
      - float
    doc: Hit E-value threshold for reporting (evalue method, default 1).
    inputBinding:
      position: 201
      prefix: --report-hit-evalue-threshold
  - id: seq_bitscore_threshold
    type:
      - 'null'
      - float
    doc: Sequence bit score threshold (bitscore method; x > 0, default 25).
    inputBinding:
      position: 201
      prefix: --seq-bitscore-threshold
  - id: hit_bitscore_threshold
    type:
      - 'null'
      - float
    doc: Hit bit score threshold (bitscore method; x > 0, default 23).
    inputBinding:
      position: 201
      prefix: --hit-bitscore-threshold
  - id: report_seq_bitscore_threshold
    type:
      - 'null'
      - float
    doc: Sequence bit score threshold for reporting (bitscore method, default 7).
    inputBinding:
      position: 201
      prefix: --report-seq-bitscore-threshold
  - id: report_hit_bitscore_threshold
    type:
      - 'null'
      - float
    doc: Hit bit score threshold for reporting (bitscore method, default 5).
    inputBinding:
      position: 201
      prefix: --report-hit-bitscore-threshold
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: 'Output csv results file (default: <query_id>_sequence_search.csv)'
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mg-toolkit:0.10.4--pyhdfd78af_0
