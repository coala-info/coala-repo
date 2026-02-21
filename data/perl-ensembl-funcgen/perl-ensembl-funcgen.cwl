cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-ensembl-funcgen
label: perl-ensembl-funcgen
doc: "Ensembl Functional Genomics API/toolkit. (Note: The provided help text contains
  only system error messages indicating the executable was not found, and does not
  list specific arguments or usage instructions.)\n\nTool homepage: https://www.ensembl.org/info/docs/api/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-ensembl-funcgen:98--0
stdout: perl-ensembl-funcgen.out
