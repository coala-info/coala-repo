cwlVersion: v1.2
class: CommandLineTool
baseCommand: pysradb doi-to-identifiers
label: pysradb_doi-to-identifiers
doc: "Convert DOI(s) to SRA/GEO identifiers.\n\nTool homepage: https://github.com/saketkc/pysradb"
inputs:
  - id: doi_ids
    type:
      type: array
      items: string
    doc: DOI(s)
    inputBinding:
      position: 1
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
