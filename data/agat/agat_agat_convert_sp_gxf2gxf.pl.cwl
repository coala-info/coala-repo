cwlVersion: v1.2
class: CommandLineTool
baseCommand: agat_agat_convert_sp_gxf2gxf.pl
label: agat_agat_convert_sp_gxf2gxf.pl
doc: "A tool from the AGAT suite for converting GXF files. (Note: The provided help
  text contains system error messages regarding a container build failure and does
  not list command-line arguments).\n\nTool homepage: https://github.com/NBISweden/AGAT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agat:1.6.1--pl5321hdfd78af_1
stdout: agat_agat_convert_sp_gxf2gxf.pl.out
