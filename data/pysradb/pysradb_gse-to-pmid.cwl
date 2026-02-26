cwlVersion: v1.2
class: CommandLineTool
baseCommand: pysradb gse-to-pmid
label: pysradb_gse-to-pmid
doc: "Convert GSE accession(s) to PMID(s)\n\nTool homepage: https://github.com/saketkc/pysradb"
inputs:
  - id: gse_ids
    type:
      type: array
      items: string
    doc: GSE accession(s)
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
