cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, homodyne]
requirements:
  - class: InlineJavascriptRequirement
label: bart_homodyne
doc: "Perform homodyne reconstruction along dimension dim.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: dimension
    type: int
    doc: Dimension along which to perform homodyne reconstruction
    inputBinding:
      position: 10
  - id: fraction
    type: float
    doc: Fraction of the ramp filter to use
    inputBinding:
      position: 11
  - id: input
    type: File
    doc: Input file
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 12
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: output_name
    type: string
    doc: Output name without extension (writes <name>.cfl and <name>.hdr)
    inputBinding:
      position: 13
  - id: clear_unacquired
    type:
      - 'null'
      - boolean
    doc: Clear unacquired portion of kspace
    inputBinding:
      position: 1
      prefix: -C
  - id: input_is_image_domain
    type:
      - 'null'
      - boolean
    doc: Input is in image domain
    inputBinding:
      position: 1
      prefix: -I
  - id: phase_reference
    type:
      - 'null'
      - File
    doc: Use <phase_ref> as phase reference
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 1
      prefix: -P
      valueFrom: "$(self === null ? null : self.path.replace(/\\.cfl$/, ''))"
  - id: ramp_filter_offset
    type:
      - 'null'
      - float
    doc: Offset of ramp filter, between 0 and 1. alpha=0 is a full ramp, alpha=1
      is a horizontal line
    inputBinding:
      position: 1
      prefix: -r
  - id: use_uncentered_ffts
    type:
      - 'null'
      - boolean
    doc: use uncentered ffts
    inputBinding:
      position: 1
      prefix: -n
outputs:
  - id: output
    type: File
    doc: Output file
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output_name).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
