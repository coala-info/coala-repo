cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxator
label: taxator-tk_taxator
doc: "Taxonomic sequence classifier (Note: The provided text contains system logs
  and a fatal error rather than help documentation; therefore, no arguments could
  be extracted).\n\nTool homepage: https://github.com/fungs/taxator-tk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxator-tk:1.3.3e--0
stdout: taxator-tk_taxator.out
