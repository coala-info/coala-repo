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
    inputBinding:
      position: 101
      prefix: --input-gff3-path
  - id: output_bed_file_path
    type: string
    doc: Output or path parameter `output_bed_file_path`
    inputBinding:
      position: 102
      prefix: --output-bed-file
outputs:
  - id: output_bed_file
    type:
      - 'null'
      - File
    doc: output BED file
    outputBinding:
      glob: $(inputs.output_bed_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
