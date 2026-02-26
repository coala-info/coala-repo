cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pysradb
  - srx-to-srp
label: pysradb_srx-to-srp
doc: "Convert SRX IDs to SRP IDs\n\nTool homepage: https://github.com/saketkc/pysradb"
inputs:
  - id: srx_ids
    type:
      type: array
      items: string
    doc: SRX IDs to convert
    inputBinding:
      position: 1
  - id: detailed_output
    type:
      - 'null'
      - boolean
    doc: 'Output additional columns: [run_accession (SRR), sample_accession (SRS),
      experiment_alias (GSM), run_alias (GSM_r), sample_alias (GSM), study_alias (GSE)]'
    inputBinding:
      position: 102
      prefix: --detailed
  - id: expand_sample_attribute
    type:
      - 'null'
      - boolean
    doc: Should sample_attribute be expanded
    inputBinding:
      position: 102
      prefix: --expand
  - id: include_sample_attribute
    type:
      - 'null'
      - boolean
    doc: Should sample_attribute be included
    inputBinding:
      position: 102
      prefix: --desc
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
