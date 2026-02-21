cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bioformats
  - interval2bed
label: bioformats_interval2bed
doc: "Convert interval files to BED format.\n\nTool homepage: https://github.com/gtamazian/bioformats"
inputs:
  - id: interval_file
    type: File
    doc: Input interval file
    inputBinding:
      position: 1
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: bed_file
    type: File
    doc: Output BED file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioformats:0.1.15--py27_0
