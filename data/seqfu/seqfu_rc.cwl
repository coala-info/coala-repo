cwlVersion: v1.2
class: CommandLineTool
baseCommand: rc
label: seqfu_rc
doc: "Print the reverse complementary of sequences in files or sequences given as
  parameters. Can read FASTA/FASTQ also from STDIN, but not naked strings.\n\nTool
  homepage: http://github.com/quadram-institute-bioscience/seqfu/"
inputs:
  - id: strings_or_files
    type:
      - 'null'
      - type: array
        items: string
    doc: Sequences or files to process
    inputBinding:
      position: 1
  - id: only_rev
    type:
      - 'null'
      - boolean
    doc: Reverse, do not complement
    inputBinding:
      position: 102
      prefix: --only-rev
  - id: seq_name
    type:
      - 'null'
      - string
    doc: Sequence name if coming as string
    inputBinding:
      position: 102
      prefix: --seq-name
  - id: strip_comments
    type:
      - 'null'
      - boolean
    doc: Remove sequence comments
    inputBinding:
      position: 102
      prefix: --strip-comments
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
stdout: seqfu_rc.out
