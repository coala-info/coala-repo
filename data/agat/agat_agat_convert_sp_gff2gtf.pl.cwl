cwlVersion: v1.2
class: CommandLineTool
baseCommand: agat_agat_convert_sp_gff2gtf.pl
label: agat_agat_convert_sp_gff2gtf.pl
doc: "The provided text does not contain help information. It is a system error log
  indicating a 'no space left on device' failure during a container build.\n\nTool
  homepage: https://github.com/NBISweden/AGAT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agat:1.6.1--pl5321hdfd78af_1
stdout: agat_agat_convert_sp_gff2gtf.pl.out
