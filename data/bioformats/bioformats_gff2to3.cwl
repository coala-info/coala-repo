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
  - id: inplace_or_ignore
    type:
      - 'null'
      - boolean
    doc: Optional flag for the gff2to3 conversion process
    inputBinding:
      position: 102
      prefix: -i
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: output_file
    type: File
    doc: Output GFF3 file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioformats:0.1.15--py27_0
