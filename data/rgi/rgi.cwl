cwlVersion: v1.2
class: CommandLineTool
baseCommand: rgi
label: rgi
doc: "Use the Resistance Gene Identifier to predict resistome(s) from protein or nucleotide
  data based on homology and SNP models. Check https://card.mcmaster.ca/download for
  software and data updates. Receive email notification of monthly CARD updates via
  the CARD Mailing List (https://mailman.mcmaster.ca/mailman/listinfo/card-l)\n\n\
  Tool homepage: https://card.mcmaster.ca"
inputs:
  - id: command
    type: string
    doc: Subcommand to run
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rgi:6.0.5--pyh05cac1d_0
stdout: rgi.out
