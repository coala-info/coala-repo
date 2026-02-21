cwlVersion: v1.2
class: CommandLineTool
baseCommand: agat_agat_sp_manage_utrs.pl
label: agat_agat_sp_manage_utrs.pl
doc: "This script allows to extend UTRs, or to add UTRs when they are missing. It
  uses the protein_coding information to define the UTRs.\n\nTool homepage: https://github.com/NBISweden/AGAT"
inputs:
  - id: five_prime
    type:
      - 'null'
      - int
    doc: Value in bp to extend or add the 5' UTR.
    inputBinding:
      position: 101
      prefix: --five
  - id: gff
    type: File
    doc: Input GFF3 file.
    inputBinding:
      position: 101
      prefix: --gff
  - id: number
    type:
      - 'null'
      - int
    doc: Value in bp to extend or add both UTRs (3' and 5').
    inputBinding:
      position: 101
      prefix: --number
  - id: three_prime
    type:
      - 'null'
      - int
    doc: Value in bp to extend or add the 3' UTR.
    inputBinding:
      position: 101
      prefix: --three
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output GFF3 file.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agat:1.6.1--pl5321hdfd78af_1
