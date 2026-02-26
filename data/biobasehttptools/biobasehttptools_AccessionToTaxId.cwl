cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobasehttptools_AccessionToTaxId
label: biobasehttptools_AccessionToTaxId
doc: "Convert NCBI accession numbers to TaxIds.\n\nTool homepage: https://github.com/eggzilla/BiobaseHTTPTools"
inputs:
  - id: accession
    type: string
    doc: NCBI accession number, e.g NC_000913
    inputBinding:
      position: 101
      prefix: --accession
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet verbosity
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Loud verbosity
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobasehttptools:1.1.0--0
stdout: biobasehttptools_AccessionToTaxId.out
