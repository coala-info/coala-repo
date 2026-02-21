cwlVersion: v1.2
class: CommandLineTool
baseCommand: agat_sp_filter_by_orf_size.pl
label: agat_agat_sp_filter_by_orf_size.pl
doc: "A tool from the AGAT suite to filter features based on their ORF (Open Reading
  Frame) size. Note: The provided help text contains system error messages regarding
  a failed container build and does not list specific command-line arguments.\n\n
  Tool homepage: https://github.com/NBISweden/AGAT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agat:1.6.1--pl5321hdfd78af_1
stdout: agat_agat_sp_filter_by_orf_size.pl.out
