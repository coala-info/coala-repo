cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqfu
  - rc
label: seqfu_rc
doc: "Print the reverse complementary of sequences in files or sequences\ngiven as parameters. Can read\
  \ FASTA/FASTQ also from STDIN, but not\nnaked strings.\n\nTool homepage: http://github.com/quadram-institute-bioscience/seqfu/"
inputs:
  - id: sequences
    type:
      - 'null'
      - type: array
        items: string
    doc: DNA strings to reverse complement
    inputBinding:
      position: 1
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTA/FASTQ files to reverse complement
    inputBinding:
      position: 2
  - id: seq_name
    type:
      - 'null'
      - string
    doc: 'Sequence name if coming as string [default: dna]'
    inputBinding:
      position: 102
      prefix: --seq-name
  - id: only_rev
    type:
      - 'null'
      - boolean
    doc: Reverse, do not complement
    inputBinding:
      position: 102
      prefix: --only-rev
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
