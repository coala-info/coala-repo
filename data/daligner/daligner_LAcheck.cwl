cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - LAcheck
label: daligner_LAcheck
doc: "Check the integrity of .las alignment files against their source
  database(s), and optionally that they are sorted.\n\nTool homepage:
  https://github.com/thegenemyers/DALIGNER"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode, output error messages.
    inputBinding:
      position: 1
      prefix: -v
  - id: check_sorted
    type:
      - 'null'
      - boolean
    doc: Check that .las is in sorted order.
    inputBinding:
      position: 1
      prefix: -S
  - id: sort_by_a_position
    type:
      - 'null'
      - boolean
    doc: If -S, then check sorted by A-read, A-position pairs (off = check 
      sorted by A,B-read pairs (LA-piles)).
    inputBinding:
      position: 1
      prefix: -a
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
  - id: alignments
    type:
      type: array
      items: File
    doc: The .las files to check
    inputBinding:
      position: 4
outputs:
  - id: report
    type: stdout
    doc: Check report (record counts and errors)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/daligner:2.0.20240118--h7b50bb2_0
stdout: daligner_LAcheck.out
