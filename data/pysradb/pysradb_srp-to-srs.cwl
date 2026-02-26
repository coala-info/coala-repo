cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pysradb
  - srp-to-srs
label: pysradb_srp-to-srs
doc: "Convert SRP accession to SRS accession\n\nTool homepage: https://github.com/saketkc/pysradb"
inputs:
  - id: srp_id
    type: string
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
    doc: 'Output additional columns: [run_accession (SRR), study_accession (SRP),
      experiment_alias (GSM), sample_alias (GSM_), run_alias (GSM_r), study_alias
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
