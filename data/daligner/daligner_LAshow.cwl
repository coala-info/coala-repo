cwlVersion: v1.2
class: CommandLineTool
baseCommand: LAshow
label: daligner_LAshow
doc: "Display local alignments produced by daligner in a human-readable format.\n\n
  Tool homepage: https://github.com/thegenemyers/DALIGNER"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: src
    type: File
    doc: The source database or dam file (.db or .dam)
    inputBinding:
      position: 1
    secondaryFiles:
      - pattern: '${ return "." + self.nameroot + ".idx"; }'
      - pattern: '${ return "." + self.nameroot + ".bps"; }'
      - pattern: '${ return "." + self.nameroot + ".hdr"; }'
        required: false
  - id: src2
    type:
      - 'null'
      - File
    doc: Second source database or dam file (.db or .dam) when the B-reads come
      from another database
    inputBinding:
      position: 2
    secondaryFiles:
      - pattern: '${ return "." + self.nameroot + ".idx"; }'
      - pattern: '${ return "." + self.nameroot + ".bps"; }'
      - pattern: '${ return "." + self.nameroot + ".hdr"; }'
        required: false
  - id: align
    type: File
    doc: The alignment file (.las)
    inputBinding:
      position: 3
  - id: reads
    type:
      - 'null'
      - type: array
        items: string
    doc: Optional reads or read ranges to display (for example 1-10)
    inputBinding:
      position: 4
  - id: reads_file
    type:
      - 'null'
      - File
    doc: Optional file listing the reads to display
    inputBinding:
      position: 5
  - id: cartoon
    type:
      - 'null'
      - boolean
    doc: Show a cartoon of the LA between reads.
    inputBinding:
      position: 0
      prefix: -c
  - id: all_alignments
    type:
      - 'null'
      - boolean
    doc: Show the alignment of each LA.
    inputBinding:
      position: 0
      prefix: -a
  - id: reference_rows
    type:
      - 'null'
      - boolean
    doc: Show the alignment of each LA with -w bp's of A in each row.
    inputBinding:
      position: 0
      prefix: -r
  - id: only_overlaps
    type:
      - 'null'
      - boolean
    doc: Show only proper overlaps.
    inputBinding:
      position: 0
      prefix: -o
  - id: flip_roles
    type:
      - 'null'
      - boolean
    doc: Switch the roles of A- and B-reads.
    inputBinding:
      position: 0
      prefix: -F
  - id: upper_case
    type:
      - 'null'
      - boolean
    doc: Show alignments in upper case.
    inputBinding:
      position: 0
      prefix: -U
  - id: indent
    type:
      - 'null'
      - int
    doc: Indent alignments and cartoons by -i. Default 4.
    inputBinding:
      position: 0
      prefix: -i
      separate: false
  - id: width
    type:
      - 'null'
      - int
    doc: Width of each row of alignment in symbols (-a) or bps (-r). Default
      100.
    inputBinding:
      position: 0
      prefix: -w
      separate: false
  - id: border
    type:
      - 'null'
      - int
    doc: Number of border bp.s to show on each side of LA. Default 10.
    inputBinding:
      position: 0
      prefix: -b
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/daligner:2.0.20240118--h7b50bb2_0
stdout: daligner_LAshow.out
