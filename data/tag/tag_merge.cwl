cwlVersion: v1.2
class: CommandLineTool
baseCommand: tag merge
label: tag_merge
doc: "Merges multiple GFF3 files into a single GFF3 file.\n\nTool homepage: https://github.com/standage/tag/"
inputs:
  - id: gff3_files
    type:
      type: array
      items: File
    doc: input files in GFF3 format
    inputBinding:
      position: 1
  - id: relax
    type:
      - 'null'
      - boolean
    doc: relax parsing stringency
    inputBinding:
      position: 102
      prefix: --relax
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: write output in GFF3 to FILE; default is terminal (stdout)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tag:0.5.1--py_0
