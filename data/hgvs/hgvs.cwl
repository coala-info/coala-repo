cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgvs
label: hgvs
doc: "The hgvs package provides a library to parse, format, validate, and map variants
  according to the Human Genome Variation Society (HGVS) nomenclature.\n\nTool homepage:
  https://github.com/biocommons/hgvs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hgvs:1.5.6--pyhdfd78af_0
stdout: hgvs.out
