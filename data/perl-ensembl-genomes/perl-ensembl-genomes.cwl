cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-ensembl-genomes
label: perl-ensembl-genomes
doc: "The provided text does not contain help information as the executable was not
  found in the environment.\n\nTool homepage: https://www.ensembl.org/info/docs/api/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-ensembl-genomes:44--0
stdout: perl-ensembl-genomes.out
