cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pysradb
  - srr-to-gsm
label: pysradb_srr-to-gsm
doc: "Convert SRR IDs to GSM IDs\n\nTool homepage: https://github.com/saketkc/pysradb"
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
    doc: 'Output additional columns: [experiment_accession (SRX), study_accession
      (SRP), run_alias (GSM_r), sample_alias (GSM_), experiment_alias (GSM), study_alias
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
