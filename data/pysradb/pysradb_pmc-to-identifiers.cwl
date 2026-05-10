cwlVersion: v1.2
class: CommandLineTool
baseCommand: pysradb pmc-to-identifiers
label: pysradb_pmc-to-identifiers
doc: "Convert PMC IDs to accession identifiers.\n\nTool homepage: https://github.com/saketkc/pysradb"
inputs:
  - id: pmc_ids
    type:
      type: array
      items: string
    doc: PMC ID(s)
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
