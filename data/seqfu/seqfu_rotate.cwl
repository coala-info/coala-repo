cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqfu
  - rotate
label: seqfu_rotate
doc: "Rotate the sequences of one or more sequence files using\ncoordinates or motifs.\n\nTool homepage:\
  \ http://github.com/quadram-institute-bioscience/seqfu/"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTA/FASTQ files
    inputBinding:
      position: 1
  - id: start_pos
    type:
      - 'null'
      - int
    doc: 'Restart from base POS, where 1 is the first base [default: 1]'
    inputBinding:
      position: 102
      prefix: --start-pos
  - id: motif
    type:
      - 'null'
      - string
    doc: Rotate sequences using motif STR as the new start, where STR is a string of bases
    inputBinding:
      position: 102
      prefix: --motif
  - id: skip_unmatched
    type:
      - 'null'
      - boolean
    doc: If a motif is provided, skip sequences that do not match the motif
    inputBinding:
      position: 102
      prefix: --skip-unmached
  - id: revcomp
    type:
      - 'null'
      - boolean
    doc: Also scan for reverse complemented motif
    inputBinding:
      position: 102
      prefix: --revcomp
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
stdout: seqfu_rotate.out
