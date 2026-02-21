cwlVersion: v1.2
class: CommandLineTool
baseCommand: impute2_impute_genome.pl
label: impute2_impute_genome.pl
doc: "A script for genome imputation using IMPUTE2. (Note: The provided text contains
  system error logs regarding container execution and does not include usage instructions
  or argument definitions.)\n\nTool homepage: https://github.com/johnlees/23andme-impute"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/impute2:2.3.2--1
stdout: impute2_impute_genome.pl.out
