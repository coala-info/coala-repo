cwlVersion: v1.2
class: CommandLineTool
baseCommand: ALNshow
label: fastga_ALNshow
doc: "Lists the alignments of a .1aln file, optionally with the base-level alignment.\n\nTool homepage: https://github.com/thegenemyers/FASTGA"
arguments:
  - position: 100
    valueFrom: $(inputs.alignments.basename)
inputs:
  - id: alignments
    type: File
    doc: Alignment file (.1aln) made by FastGA.
  - id: sources
    type: File[]
    doc: Source genome files (for example FASTA) named in the alignment file; they are staged beside it.
  - id: selection
    type:
      - 'null'
      - string[]
    doc: Optional selections or files of selections (see the tool help for the grammar).
    inputBinding:
      position: 101
  - id: show_alignment
    type:
      - 'null'
      - boolean
    doc: Show the alignment of each local alignment with -w columns in each row.
    inputBinding:
      position: 101
      prefix: '-a'
  - id: show_alignment_bp
    type:
      - 'null'
      - boolean
    doc: 'Show the alignment of each local alignment with -w bp''s of A in each row.'
    inputBinding:
      position: 101
      prefix: '-r'
  - id: upper_case
    type:
      - 'null'
      - boolean
    doc: Show alignments in upper case.
    inputBinding:
      position: 101
      prefix: '-U'
  - id: indent
    type:
      - 'null'
      - int
    doc: 'Indent alignments by -i spaces. [default: 4]'
    inputBinding:
      position: 101
      prefix: '-i'
      separate: false
  - id: width
    type:
      - 'null'
      - int
    doc: 'Width of each row of alignment in symbols (-a) or bps (-r). [default: 100]'
    inputBinding:
      position: 101
      prefix: '-w'
      separate: false
  - id: border
    type:
      - 'null'
      - int
    doc: 'Number of bordering bp.s to show on each side of the alignment. [default: 10]'
    inputBinding:
      position: 101
      prefix: '-b'
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.alignments)
      - $(inputs.sources)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
stdout: fastga_ALNshow.out
