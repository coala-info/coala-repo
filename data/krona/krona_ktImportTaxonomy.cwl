cwlVersion: v1.2
class: CommandLineTool
baseCommand: ktImportTaxonomy
label: krona_ktImportTaxonomy
doc: "Krona is a tool for visualizing hierarchical data (such as taxonomy) as multi-layered
  pie charts. (Note: The provided help text contained only system error messages and
  no usage information; arguments could not be extracted from the source text).\n\n
  Tool homepage: https://github.com/marbl/Krona"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1
stdout: krona_ktImportTaxonomy.out
