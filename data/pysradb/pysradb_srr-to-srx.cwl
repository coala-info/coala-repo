cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pysradb
  - srr-to-srx
label: pysradb_srr-to-srx
doc: "Convert SRR IDs to SRX IDs.\n\nTool homepage: https://github.com/saketkc/pysradb"
inputs:
  - id: srr_ids
    type:
      type: array
      items: string
    doc: SRR IDs to convert
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
    doc: 'Output additional columns: [sample_accession (SRS), study_accession (SRP),
      run_alias (GSM_r), experiment_alias (GSM), sample_alias (GSM_), study_alias
      (GSE)]'
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
