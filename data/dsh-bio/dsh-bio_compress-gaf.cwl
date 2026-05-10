cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-compress-gaf
label: dsh-bio_compress-gaf
doc: "Compresses a GAF file.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: input_gaf_path
    type:
      - 'null'
      - File
    doc: input GAF path
    inputBinding:
      position: 101
      prefix: --input-gaf-path
  - id: output_gaf_file_path
    type: string
    doc: Output or path parameter `output_gaf_file_path`
    inputBinding:
      position: 102
      prefix: --output-gaf-file
outputs:
  - id: output_gaf_file
    type:
      - 'null'
      - File
    doc: output GAF file
    outputBinding:
      glob: $(inputs.output_gaf_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
