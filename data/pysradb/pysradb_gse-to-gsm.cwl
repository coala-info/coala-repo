cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pysradb
  - gse-to-gsm
label: pysradb_gse-to-gsm
doc: "Convert GSE accession IDs to GSM accession IDs\n\nTool homepage: https://github.com/saketkc/pysradb"
inputs:
  - id: gse_ids
    type:
      type: array
      items: string
    doc: GSE accession IDs
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
    doc: 'Output additional columns: [sample_accession (SRS), run_accession (SRR),
      sample_alias (GSM), run_alias (GSM_r)]'
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
