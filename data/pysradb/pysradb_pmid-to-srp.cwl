cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pysradb
  - pmid-to-srp
label: pysradb_pmid-to-srp
doc: "Convert PMID(s) to SRP accession(s)\n\nTool homepage: https://github.com/saketkc/pysradb"
inputs:
  - id: pmid_ids
    type:
      type: array
      items: string
    doc: PMID(s)
    inputBinding:
      position: 1
  - id: saveto_path
    type: string?
    doc: Save metadata dataframe to file
    inputBinding:
      position: 101
      prefix: --saveto
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (the result table when no --saveto file is given)
  - id: saveto
    type:
      - 'null'
      - File
    doc: Save output to file
    outputBinding:
      glob: $(inputs.saveto_path)
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pysradb:2.5.1--pyhdfd78af_0
stdout: pysradb_pmid-to-srp.out
