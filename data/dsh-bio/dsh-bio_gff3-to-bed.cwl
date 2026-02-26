cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-gff3-to-bed
label: dsh-bio_gff3-to-bed
doc: "Converts GFF3 format to BED format.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_gff3_path
    type:
      - 'null'
      - File
    doc: input GFF3 path
    default: stdin
    inputBinding:
      position: 101
      prefix: --input-gff3-path
outputs:
  - id: output_bed_file
    type:
      - 'null'
      - File
    doc: output BED file
    outputBinding:
      glob: $(inputs.output_bed_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
