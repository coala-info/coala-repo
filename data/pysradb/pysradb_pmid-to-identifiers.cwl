cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pysradb
  - pmid-to-identifiers
label: pysradb_pmid-to-identifiers
doc: "Convert PMID(s) to SRA accession(s) and Experiment accession(s)\n\nTool homepage:
  https://github.com/saketkc/pysradb"
inputs:
  - id: pmid_ids
    type:
      type: array
      items: string
    doc: PMID(s)
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
