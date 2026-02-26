cwlVersion: v1.2
class: CommandLineTool
baseCommand: genepender
label: genepender
doc: "Appends a new column containing gene names, whilst filtering out intergenic
  regions (i.e. where there are no genes), and can also optionally filter out introns.\n\
  \nTool homepage: https://github.com/BioTools-Tek/genepender"
inputs:
  - id: genemap
    type: File
    doc: Gene map file (chr<TAB>index<TAB>...)
    inputBinding:
      position: 1
  - id: vcfs
    type:
      - 'null'
      - type: array
        items: File
    doc: VCF files to process
    inputBinding:
      position: 2
  - id: force
    type:
      - 'null'
      - boolean
    doc: Forces reprocessing even if VCF header present in either in/out file
    inputBinding:
      position: 103
      prefix: --force
  - id: keepall
    type:
      - 'null'
      - boolean
    doc: Also keeps variants that only fall within intron/intergenic regions.
    inputBinding:
      position: 103
      prefix: --keepall
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Root output folder, source folder otherwise
    inputBinding:
      position: 103
      prefix: --output-folder
  - id: prefix_extract
    type:
      - 'null'
      - string
    doc: Preserves directory structure starting from prefix value. Dumped into 
      root of output folder otherwise.
    inputBinding:
      position: 103
      prefix: --prefix-extract
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genepender:v2.6--h470a237_1
stdout: genepender.out
