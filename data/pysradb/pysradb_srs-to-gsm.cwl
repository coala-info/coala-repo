cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pysradb
  - srs-to-gsm
label: pysradb_srs-to-gsm
doc: "Convert SRS IDs to GSM IDs\n\nTool homepage: https://github.com/saketkc/pysradb"
inputs:
  - id: srs_ids
    type:
      type: array
      items: string
    doc: SRS IDs to convert
    inputBinding:
      position: 1
  - id: desc
    type:
      - 'null'
      - boolean
    doc: Should sample_attribute be included
    inputBinding:
      position: 102
      prefix: --desc
  - id: detailed
    type:
      - 'null'
      - boolean
    doc: 'Output additional columns: [run_accession, study_accession]'
    inputBinding:
      position: 102
      prefix: --detailed
  - id: expand
    type:
      - 'null'
      - boolean
    doc: Should sample_attribute be expanded
    inputBinding:
      position: 102
      prefix: --expand
outputs:
  - id: saveto
    type:
      - 'null'
      - File
    doc: Save output to file
    outputBinding:
      glob: $(inputs.saveto)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
