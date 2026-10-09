cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - maq
  - cns2win
label: maq_cns2win
doc: "Convert consensus sequences to windowed format.\n\nTool homepage: http://maq.sourceforge.net/"
inputs:
  - id: input_cns
    type: File
    doc: Input consensus sequence file
    inputBinding:
      position: 1
  - id: chromosome
    type:
      - 'null'
      - string
    doc: Name of the sequence (chromosome) to report; default is all
    inputBinding:
      position: 102
      prefix: -c
  - id: begin_position
    type:
      - 'null'
      - int
    doc: Begin position of the region
    inputBinding:
      position: 102
      prefix: -b
  - id: end_position
    type:
      - 'null'
      - int
    doc: End position of the region
    inputBinding:
      position: 102
      prefix: -e
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum quality
    inputBinding:
      position: 102
      prefix: -q
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size
    inputBinding:
      position: 102
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maq:v0.7.1-8-deb_cv1
stdout: maq_cns2win.out
