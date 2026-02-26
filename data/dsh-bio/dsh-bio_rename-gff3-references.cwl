cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-rename-references
label: dsh-bio_rename-gff3-references
doc: "Rename chromosome references in a GFF3 file.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: chr
    type:
      - 'null'
      - boolean
    doc: add "chr" to chromosome reference names
    inputBinding:
      position: 101
      prefix: --chr
  - id: input_gff3_path
    type:
      - 'null'
      - File
    doc: input GFF3 path, default stdin
    inputBinding:
      position: 101
      prefix: --input-gff3-path
outputs:
  - id: output_gff3_file
    type:
      - 'null'
      - File
    doc: output GFF3 file, default stdout
    outputBinding:
      glob: $(inputs.output_gff3_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dsh-bio:3.0--hdfd78af_0
