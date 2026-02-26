cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pysradb
  - srp-to-srr
label: pysradb_srp-to-srr
doc: "Convert SRP accession to SRR accessions\n\nTool homepage: https://github.com/saketkc/pysradb"
inputs:
  - id: srp_id
    type: string
    doc: SRP accession ID
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
    doc: 'Output additional columns: [experiment_accession (SRX), sample_accession
      (SRS), study_alias (GSE), experiment_alias (GSM), sample_alias (GSM_), run_alias
      (GSM_r)]'
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
