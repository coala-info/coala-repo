cwlVersion: v1.2
class: CommandLineTool
baseCommand: agat_sp_gff2tsv.pl
label: agat_agat_sp_gff2tsv.pl
doc: "A tool from the AGAT suite to convert GFF files to TSV format. (Note: The provided
  help text contains only system error messages regarding a failed container build
  and does not list command-line arguments.)\n\nTool homepage: https://github.com/NBISweden/AGAT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agat:1.6.1--pl5321hdfd78af_1
stdout: agat_agat_sp_gff2tsv.pl.out
