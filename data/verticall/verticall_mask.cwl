cwlVersion: v1.2
class: CommandLineTool
baseCommand: verticall mask
label: verticall_mask
doc: "mask horizontal regions from a whole-genome pseudo-alignment\n\nTool homepage:
  https://github.com/rrwick/Verticall"
inputs:
  - id: exclude_invariant
    type:
      - 'null'
      - boolean
    doc: 'Only include variant sites in the output alignment (default: include both
      variant and invariant sites in the output alignment)'
    inputBinding:
      position: 101
      prefix: --exclude_invariant
  - id: exclude_reference
    type:
      - 'null'
      - boolean
    doc: 'Do not include the reference sequence in the output alignment (default:
      include the reference sequence in the output alignment)'
    inputBinding:
      position: 101
      prefix: --exclude_reference
  - id: h_char
    type:
      - 'null'
      - string
    doc: Character used to mask horizontal regions
    inputBinding:
      position: 101
      prefix: --h_char
  - id: horizontal_colour
    type:
      - 'null'
      - string
    doc: Hex colour for horizontal inheritance
    inputBinding:
      position: 101
      prefix: --horizontal_colour
  - id: image
    type:
      - 'null'
      - File
    doc: Filename of SVG illustration of masked regions (optional)
    inputBinding:
      position: 101
      prefix: --image
  - id: in_alignment
    type: File
    doc: Filename of whole-genome pseudo-alignment to be masked
    inputBinding:
      position: 101
      prefix: --in_alignment
  - id: in_tsv
    type: File
    doc: Filename of TSV created by vertical pairwise
    inputBinding:
      position: 101
      prefix: --in_tsv
  - id: multi
    type:
      - 'null'
      - string
    doc: Behaviour when there are multiple results for a sample pair
    inputBinding:
      position: 101
      prefix: --multi
  - id: reference
    type:
      - 'null'
      - string
    doc: Sample name for the reference genome
    inputBinding:
      position: 101
      prefix: --reference
  - id: u_char
    type:
      - 'null'
      - string
    doc: Character used to mask unaligned regions
    inputBinding:
      position: 101
      prefix: --u_char
  - id: unaligned_colour
    type:
      - 'null'
      - string
    doc: Hex colour for unaligned inheritance
    inputBinding:
      position: 101
      prefix: --unaligned_colour
  - id: vertical_colour
    type:
      - 'null'
      - string
    doc: Hex colour for vertical inheritance
    inputBinding:
      position: 101
      prefix: --vertical_colour
outputs:
  - id: out_alignment
    type: File
    doc: Filename of masked whole-genome pseudo-alignment
    outputBinding:
      glob: $(inputs.out_alignment)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/verticall:0.4.3--pyhdfd78af_0
