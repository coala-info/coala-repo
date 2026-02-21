cwlVersion: v1.2
class: CommandLineTool
baseCommand: agat_agat_sp_statistics.pl
label: agat_agat_sp_statistics.pl
doc: "The provided text contains system error messages related to a container build
  failure ('no space left on device') and does not contain the help documentation
  for the tool. Based on the tool name hint, this script is part of the AGAT (Another
  GFF Analysis Toolkit) suite used for calculating statistics on GFF/GTF files.\n\n
  Tool homepage: https://github.com/NBISweden/AGAT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agat:1.6.1--pl5321hdfd78af_1
stdout: agat_agat_sp_statistics.pl.out
