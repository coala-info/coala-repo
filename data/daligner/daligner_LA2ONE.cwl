cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - LA2ONE
label: daligner_LA2ONE
doc: "Convert a .las alignment file to ONE-code (.dal) text format. Outputs
  pile reads, orientation, and chains by default (P, O, C lines).\n\nTool
  homepage: https://github.com/thegenemyers/DALIGNER"
requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement
arguments:
  - position: 100
    valueFrom: '> $(inputs.output_name)'
    shellQuote: false
inputs:
  - id: coordinates
    type:
      - 'null'
      - boolean
    doc: Output also aligned intervals, read lengths, and diffs (B, E, L, and D 
      lines)
    inputBinding:
      position: 1
      prefix: -c
  - id: traces
    type:
      - 'null'
      - boolean
    doc: Output also traces (T and Q lines)
    inputBinding:
      position: 1
      prefix: -t
  - id: only_overlaps
    type:
      - 'null'
      - boolean
    doc: Output proper overlaps only
    inputBinding:
      position: 1
      prefix: -o
  - id: src
    type: File
    doc: Source database (.db or .dam)
    inputBinding:
      position: 2
    secondaryFiles:
      - pattern: '${ return "." + self.nameroot + ".idx"; }'
      - pattern: '${ return "." + self.nameroot + ".bps"; }'
      - pattern: '${ return "." + self.nameroot + ".hdr"; }'
        required: false
  - id: src2
    type:
      - 'null'
      - File
    doc: Second source database (.db or .dam) for the B-reads
    inputBinding:
      position: 3
    secondaryFiles:
      - pattern: '${ return "." + self.nameroot + ".idx"; }'
      - pattern: '${ return "." + self.nameroot + ".bps"; }'
      - pattern: '${ return "." + self.nameroot + ".hdr"; }'
        required: false
  - id: align
    type: File
    doc: The alignment file (.las)
    inputBinding:
      position: 4
  - id: reads
    type:
      - 'null'
      - type: array
        items: string
    doc: Optional reads or read ranges to output
    inputBinding:
      position: 5
  - id: reads_file
    type:
      - 'null'
      - File
    doc: Optional file listing the reads to output
    inputBinding:
      position: 6
  - id: output_name
    type:
      - 'null'
      - string
    doc: Name of the ONE-code output file
    default: alignments.dal
outputs:
  - id: one_file
    type: File
    doc: ONE-code alignment file (.dal). LA2ONE needs a seekable output file, 
      so it is written with a shell redirect, not through a pipe.
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/daligner:2.0.20240118--h7b50bb2_0
