cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - LAsplit
label: daligner_LAsplit
doc: "Split a .las alignment file, read from standard input, into parts. The
  target is a template with a single @-sign that is replaced by the numbers 1
  to n. The split is into a given number of parts, or by the blocks of a split
  database.\n\nTool homepage: https://github.com/thegenemyers/DALIGNER"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode.
    inputBinding:
      position: 1
      prefix: -v
  - id: target
    type: string
    doc: Output name template with a single @-sign (for example part@)
    inputBinding:
      position: 2
  - id: parts
    type:
      - 'null'
      - int
    doc: Number of parts to split into (give this or split_db)
    inputBinding:
      position: 3
  - id: split_db
    type:
      - 'null'
      - File
    doc: Split database (.db or .dam); the .las is split by its blocks (give 
      this or parts)
    inputBinding:
      position: 3
    secondaryFiles:
      - pattern: '${ return "." + self.nameroot + ".idx"; }'
      - pattern: '${ return "." + self.nameroot + ".bps"; }'
      - pattern: '${ return "." + self.nameroot + ".hdr"; }'
        required: false
  - id: source
    type: File
    doc: The .las file to split (read from standard input)
outputs:
  - id: split_alignments
    type:
      type: array
      items: File
    doc: The parts (<target> with @ replaced by 1..n, .las)
    outputBinding:
      glob: '$(inputs.target.replace("@", "*").replace(/\.las$/, "") + ".las")'
stdin: $(inputs.source.path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/daligner:2.0.20240118--h7b50bb2_0
