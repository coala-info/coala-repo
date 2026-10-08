cwlVersion: v1.2
class: CommandLineTool
baseCommand: ALNtoPAF
label: fastga_ALNtoPAF
doc: "Converts a .1aln alignment file to PAF format.\n\nTool homepage: https://github.com/thegenemyers/FASTGA"
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
  - id: cigar_m
    type:
      - 'null'
      - boolean
    doc: 'Produce Cigar string tag with M''s.'
    inputBinding:
      position: 101
      prefix: '-m'
  - id: cigar_x
    type:
      - 'null'
      - boolean
    doc: 'Produce Cigar string tag with X''s and =''s.'
    inputBinding:
      position: 101
      prefix: '-x'
  - id: cs_short
    type:
      - 'null'
      - boolean
    doc: Produce CS string tag in short form.
    inputBinding:
      position: 101
      prefix: '-s'
  - id: cs_long
    type:
      - 'null'
      - boolean
    doc: Produce CS string tag in long form.
    inputBinding:
      position: 101
      prefix: '-S'
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use. [default: 8]'
    inputBinding:
      position: 101
      prefix: '-T'
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
stdout: fastga_ALNtoPAF.out
