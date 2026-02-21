cwlVersion: v1.2
class: CommandLineTool
baseCommand: gbsx
label: gbsx
doc: "GBSX (Genotype-by-Sequencing Barcode Demultiplexer). Note: The provided text
  contains system error messages rather than help documentation, so no arguments could
  be extracted.\n\nTool homepage: https://github.com/GenomicsCoreLeuven/GBSX"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gbsx:1.3--0
stdout: gbsx.out
