cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bioformats
  - gff2to3
label: bioformats_gff2to3
doc: "Convert GFF2 files to GFF3 format using the bioformats toolset.\n\nTool homepage:
  https://github.com/gtamazian/bioformats"
inputs:
  - id: gff2_file
    type: File
    doc: Input GFF2 file to be converted
    inputBinding:
      position: 1
  - id: output_file
    type: string
    doc: the output GFF3 file
    inputBinding:
      position: 2
  - id: ignore_incorrect_records
    type:
      - 'null'
      - boolean
    doc: ignore incorrect records in the specified input GFF2 file
    inputBinding:
      position: 102
      prefix: --ignore_incorrect_records
outputs:
  - id: out_output_file
    type: File
    doc: Output GFF3 file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioformats:0.1.15--py27_0
