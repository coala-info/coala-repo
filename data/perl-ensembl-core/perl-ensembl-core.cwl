cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-ensembl-core
label: perl-ensembl-core
doc: "The Ensembl Core Perl API and infrastructure.\n\nTool homepage: https://www.ensembl.org/info/docs/api/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-ensembl-core:98--0
stdout: perl-ensembl-core.out
