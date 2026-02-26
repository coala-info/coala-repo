cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pysradb
  - srx-to-srr
label: pysradb_srx-to-srr
doc: "Convert SRX IDs to SRR IDs\n\nTool homepage: https://github.com/saketkc/pysradb"
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
    doc: 'Output additional columns: [sample_accession, study_accession]'
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
