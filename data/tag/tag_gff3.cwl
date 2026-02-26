cwlVersion: v1.2
class: CommandLineTool
baseCommand: tag gff3
label: tag_gff3
doc: "Processes GFF3 files.\n\nTool homepage: https://github.com/standage/tag/"
inputs:
  - id: gff3
    type: File
    doc: input file in GFF3 format
    inputBinding:
      position: 1
  - id: no_sort
    type:
      - 'null'
      - boolean
    doc: do not enforce sorting of output data
    inputBinding:
      position: 102
      prefix: --no-sort
  - id: relax
    type:
      - 'null'
      - boolean
    doc: relax parsing stringency
    inputBinding:
      position: 102
      prefix: --relax
  - id: retain_ids
    type:
      - 'null'
      - boolean
    doc: retain feature IDs from input
    inputBinding:
      position: 102
      prefix: --retain-ids
  - id: sorted
    type:
      - 'null'
      - boolean
    doc: assume the input data is sorted
    inputBinding:
      position: 102
      prefix: --sorted
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: write output in GFF3 format to FILE; default is terminal (stdout)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tag:0.5.1--py_0
