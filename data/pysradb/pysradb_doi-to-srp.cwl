cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pysradb
  - doi-to-srp
label: pysradb_doi-to-srp
doc: "Convert DOI(s) to SRP accession(s)\n\nTool homepage: https://github.com/saketkc/pysradb"
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
