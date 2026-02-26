cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pysradb
  - srx-to-srs
label: pysradb_srx-to-srs
doc: "Convert SRX IDs to SRS IDs\n\nTool homepage: https://github.com/saketkc/pysradb"
inputs:
  - id: srx_ids
    type:
      type: array
      items: string
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
