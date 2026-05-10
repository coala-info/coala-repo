cwlVersion: v1.2
class: CommandLineTool
baseCommand: agat_convert_sp_gff2bed.pl
label: agat_agat_convert_sp_gff2bed.pl
doc: "The script takes a GFF file as input and converts it to BED format.\n\nTool
  homepage: https://github.com/NBISweden/AGAT"
inputs:
  - id: gff
    type: File
    doc: Input GFF3 file that will be read
    inputBinding:
      position: 101
      prefix: --gff
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output BED file. If no output file is specified, the output will be 
      written to the standard output.
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agat:1.6.1--pl5321hdfd78af_1
