cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-compress-gff3
label: dsh-bio_compress-gff3
doc: "Compresses GFF3 files.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_gff3_path
    type:
      - 'null'
      - File
    doc: input GFF3 path, default stdin
    inputBinding:
      position: 101
      prefix: --input-gff3-path
  - id: output_gff3_file_path
    type: string
    doc: Output or path parameter `output_gff3_file_path`
    inputBinding:
      position: 102
      prefix: --output-gff3-file
outputs:
  - id: output_gff3_file
    type:
      - 'null'
      - File
    doc: output GFF3 file, default stdout
    outputBinding:
      glob: $(inputs.output_gff3_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
