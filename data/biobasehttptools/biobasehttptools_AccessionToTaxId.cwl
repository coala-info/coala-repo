cwlVersion: v1.2
class: CommandLineTool
baseCommand: AccessionToTaxId
label: biobasehttptools_AccessionToTaxId
doc: "A tool to convert NCBI Accession numbers to Taxonomy IDs. Note: The provided
  help text contains system error logs indicating a failure to initialize the tool
  due to insufficient disk space, so specific arguments could not be extracted from
  the input.\n\nTool homepage: https://github.com/eggzilla/BiobaseHTTPTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobasehttptools:1.1.0--0
stdout: biobasehttptools_AccessionToTaxId.out
