cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-rename-bed-references
label: dsh-bio_rename-bed-references
doc: "Rename chromosome references in a BED file.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: add_chr
    type:
      - 'null'
      - boolean
    doc: add "chr" to chromosome reference names
    inputBinding:
      position: 101
      prefix: --chr
  - id: input_bed_path
    type:
      - 'null'
      - File
    doc: input BED path
    default: stdin
    inputBinding:
      position: 101
      prefix: --input-bed-path
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
