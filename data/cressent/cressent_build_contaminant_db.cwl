cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cressent
  - build_contaminant_db
label: cressent_build_contaminant_db
doc: "Build a viral contaminant database for decontamination pipelines.\n\nTool homepage: https://github.com/ricrocha82/cressent"
inputs:
  - id: accession_csv
    type: File
    doc: "CSV file with accessions (must have 'accession' column)"
    inputBinding:
      position: 101
      prefix: --accession-csv
  - id: output_dir
    type: string
    doc: "Path to the output directory (created by the tool; collected as the output)"
    inputBinding:
      position: 101
      prefix: --output
  - id: output_name
    type:
      - 'null'
      - string
    doc: "Base name for output files (default: contaminant_db)"
    inputBinding:
      position: 101
      prefix: --output-name
  - id: email
    type:
      - 'null'
      - string
    doc: "Email for NCBI Entrez queries (not required, default: user@example.com)"
    inputBinding:
      position: 101
      prefix: --email
  - id: batch_size
    type:
      - 'null'
      - int
    doc: "Maximum number of sequences to download in each batch (default = 10)"
    inputBinding:
      position: 101
      prefix: --batch-size
outputs:
  - id: output
    type: Directory
    doc: Output directory with all result files
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cressent:1.0.2--pyhdfd78af_0
