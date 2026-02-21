cwlVersion: v1.2
class: CommandLineTool
baseCommand: enasearch
label: enasearch
doc: "A tool to search the European Nucleotide Archive (ENA). Note: The provided help
  text contains system error messages regarding container execution and does not list
  specific command-line arguments.\n\nTool homepage: http://bebatut.fr/enasearch/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enasearch:0.2.2--py27_0
stdout: enasearch.out
