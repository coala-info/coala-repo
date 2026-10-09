cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - leviosam
  - bed
label: leviosam_bed
doc: "Lift over a BED file\n\nTool homepage: https://github.com/alshai/levioSAM"
inputs:
  - id: bed
    type: File
    doc: 'Path to the input BED.'
    inputBinding:
      position: 1
      prefix: -b
  - id: chain_index
    type: File
    doc: 'Path to the chain index.'
    inputBinding:
      position: 2
      prefix: -C
  - id: prefix
    type: string
    doc: 'Prefix to the output files.'
    inputBinding:
      position: 3
      prefix: -p
  - id: allowed_gaps
    type:
      - 'null'
      - int
    doc: 'Number of allowed gaps for an interval. [500]'
    inputBinding:
      position: 4
      prefix: -G
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: 'Verbose level [0]'
    inputBinding:
      position: 5
      prefix: -V
outputs:
  - id: prefix_files
    type: File[]
    doc: 'Files written with the prefix given in prefix'
    outputBinding:
      glob: $(inputs.prefix)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/leviosam:5.2.1--h4ac6f70_2
