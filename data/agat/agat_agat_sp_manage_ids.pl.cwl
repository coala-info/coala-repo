cwlVersion: v1.2
class: CommandLineTool
baseCommand: agat_sp_manage_ids.pl
label: agat_agat_sp_manage_ids.pl
doc: "This script allows to manage IDs in a GFF file. It can be used to add, remove,
  or change IDs.\n\nTool homepage: https://github.com/NBISweden/AGAT"
inputs:
  - id: collective
    type:
      - 'null'
      - boolean
    doc: Boolean - If you want to use the same ID for all features of the same type.
    inputBinding:
      position: 101
      prefix: --collective
  - id: gff
    type: File
    doc: Input GFF3 file that will be read
    inputBinding:
      position: 101
      prefix: --gff
  - id: type
    type:
      - 'null'
      - string
    doc: Type of ID to manage (e.g. ID, Parent, Name, etc.)
    inputBinding:
      position: 101
      prefix: --type
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output GFF file. If no output file is specified, the output will be written
      to the standard output.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agat:1.6.1--pl5321hdfd78af_1
