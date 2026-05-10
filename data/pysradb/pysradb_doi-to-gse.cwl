cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pysradb
  - doi-to-gse
label: pysradb_doi-to-gse
doc: "Convert DOI(s) to GSE accession(s)\n\nTool homepage: https://github.com/saketkc/pysradb"
inputs:
  - id: doi_ids
    type:
      type: array
      items: string
    doc: DOI(s)
    inputBinding:
      position: 1
  - id: saveto_path
    type: string
    doc: Save metadata dataframe to file
    inputBinding:
      position: 101
      prefix: --saveto
outputs:
  - id: saveto
    type:
      - 'null'
      - File
    doc: Save output to file
    outputBinding:
      glob: $(inputs.saveto_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
