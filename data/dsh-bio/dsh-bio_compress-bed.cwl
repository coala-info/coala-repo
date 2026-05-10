cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-compress-bed
label: dsh-bio_compress-bed
doc: "Compresses a BED file.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_bed_path
    type:
      - 'null'
      - File
    doc: input BED path
    inputBinding:
      position: 101
      prefix: --input-bed-path
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
