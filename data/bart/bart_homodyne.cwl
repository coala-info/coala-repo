cwlVersion: v1.2
class: CommandLineTool
baseCommand: homodyne
label: bart_homodyne
doc: "Perform homodyne reconstruction along dimension dim.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: dimension
    type: int
    doc: Dimension along which to perform homodyne reconstruction
    inputBinding:
      position: 1
  - id: fraction
    type: float
    doc: Fraction of the ramp filter to use
    inputBinding:
      position: 2
  - id: input
    type: File
    doc: Input file
    inputBinding:
      position: 3
  - id: clear_unacquired
    type:
      - 'null'
      - boolean
    doc: Clear unacquired portion of kspace
    inputBinding:
      position: 104
      prefix: -C
  - id: input_is_image_domain
    type:
      - 'null'
      - boolean
    doc: Input is in image domain
    inputBinding:
      position: 104
      prefix: -I
  - id: phase_reference
    type:
      - 'null'
      - string
    doc: Use <phase_ref> as phase reference
    inputBinding:
      position: 104
      prefix: -P
  - id: ramp_filter_offset
    type:
      - 'null'
      - float
    doc: Offset of ramp filter, between 0 and 1. alpha=0 is a full ramp, alpha=1
      is a horizontal line
    inputBinding:
      position: 104
      prefix: -r
  - id: use_uncentered_ffts
    type:
      - 'null'
      - boolean
    doc: use uncentered ffts
    inputBinding:
      position: 104
      prefix: -n
outputs:
  - id: output
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
