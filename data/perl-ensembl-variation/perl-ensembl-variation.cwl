cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-ensembl-variation
label: perl-ensembl-variation
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build or run a container image due to insufficient disk
  space.\n\nTool homepage: https://www.ensembl.org/info/docs/api/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-ensembl-variation:98--0
stdout: perl-ensembl-variation.out
