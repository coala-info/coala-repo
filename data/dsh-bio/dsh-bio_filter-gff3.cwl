cwlVersion: v1.2
class: CommandLineTool
baseCommand: dsh-filter-gff3
label: dsh-bio_filter-gff3
doc: "Filter GFF3 files based on various criteria.\n\nTool homepage: https://github.com/heuermh/dishevelled-bio"
inputs:
  - id: about
    type:
      - 'null'
      - boolean
    doc: display about message
    inputBinding:
      position: 101
      prefix: --about
  - id: input_gff3_path
    type:
      - 'null'
      - File
    doc: input GFF3 path, default stdin
    inputBinding:
      position: 101
      prefix: --input-gff3-path
  - id: range
    type:
      - 'null'
      - string
    doc: filter by range, specify as chrom:start-end in 0-based coordindates
    inputBinding:
      position: 101
      prefix: --range
  - id: score
    type:
      - 'null'
      - int
    doc: filter by score
    inputBinding:
      position: 101
      prefix: --score
  - id: script
    type:
      - 'null'
      - string
    doc: filter by script, eval against r
    inputBinding:
      position: 101
      prefix: --script
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
