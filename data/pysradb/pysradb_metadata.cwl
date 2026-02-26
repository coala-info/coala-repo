cwlVersion: v1.2
class: CommandLineTool
baseCommand: pysradb metadata
label: pysradb_metadata
doc: "Retrieve metadata for given SRP IDs.\n\nTool homepage: https://github.com/saketkc/pysradb"
inputs:
  - id: srp_id
    type:
      type: array
      items: string
    doc: SRP ID(s) to retrieve metadata for
    inputBinding:
      position: 1
  - id: assay
    type:
      - 'null'
      - boolean
    doc: Include assay type in output
    inputBinding:
      position: 102
      prefix: --assay
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
    doc: Display detailed metadata table
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
    doc: Save metadata dataframe to file
    outputBinding:
      glob: $(inputs.saveto)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
