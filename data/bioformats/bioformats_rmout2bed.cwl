cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bioformats
  - rmout2bed
label: bioformats_rmout2bed
doc: "Convert a RepeatMasker out file to the BED format.\n\nTool homepage: https://github.com/gtamazian/bioformats"
inputs:
  - id: rmout_file
    type: File
    doc: a RepeatMasker out file
    inputBinding:
      position: 1
  - id: color
    type:
      - 'null'
      - string
    doc: 'how to choose colors of BED repeat records (default: class)'
    default: class
    inputBinding:
      position: 102
      prefix: --color
  - id: name
    type:
      - 'null'
      - string
    doc: 'how to choose names of BED repeat records (default: id)'
    default: id
    inputBinding:
      position: 102
      prefix: --name
  - id: short
    type:
      - 'null'
      - boolean
    doc: 'output only repeat loci (the output is a BED3 file) (default: False)'
    default: false
    inputBinding:
      position: 102
      prefix: --short
outputs:
  - id: bed_file
    type: File
    doc: the output BED file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioformats:0.1.15--py27_0
