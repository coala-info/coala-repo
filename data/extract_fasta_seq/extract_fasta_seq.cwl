cwlVersion: v1.2
class: CommandLineTool
baseCommand: [extract_fasta_seq]
label: extract_fasta_seq
doc: "To extract specific fasta sequences from a fasta file.\n\nTool homepage: https://github.com/linzhi2013/extract_fasta_seq"
inputs:
  - id: query_ids
    type:
      - 'null'
      - type: array
        items: string
    doc: Query list. "-s1" and "-d1" have no effect on this option.
    inputBinding:
      position: 1
      prefix: -q
  - id: query_file
    type:
      - 'null'
      - File
    doc: Query list file, one line should contain only one queryid (but can be
      mixed with others, and "-s1" and "-d1" can extract the queryid).
    inputBinding:
      position: 2
      prefix: -f
  - id: subject_file
    type:
      - 'null'
      - File
    doc: Subject fasta file (default stdin).
    inputBinding:
      position: 3
      prefix: -s
  - id: query_sep_pattern
    type:
      - 'null'
      - string
    doc: Query file sep_pattern (default \s+).
    inputBinding:
      position: 4
      prefix: -s1
  - id: subject_sep_pattern
    type:
      - 'null'
      - string
    doc: Subject file sep_pattern (default \s+).
    inputBinding:
      position: 5
      prefix: -s2
  - id: query_field
    type:
      - 'null'
      - int
    doc: Which field in the query file is to be used (default 0).
    inputBinding:
      position: 6
      prefix: -d1
  - id: subject_field
    type:
      - 'null'
      - int
    doc: Which field in the subject file is to be used, to find all sequences
      whose seqids equal the queryids (default 0).
    inputBinding:
      position: 7
      prefix: -d2
  - id: outfile
    type: string
    default: extracted.fasta
    doc: Output file name.
    inputBinding:
      position: 8
      prefix: -o
  - id: invert
    type:
      - 'null'
      - boolean
    doc: Invert the output.
    inputBinding:
      position: 9
      prefix: -v
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output.
    inputBinding:
      position: 10
      prefix: -V
  - id: lazy
    type:
      - 'null'
      - boolean
    doc: Stop searching once each required seqid has at least one sequence
      found. Works only for non-invert mode.
    inputBinding:
      position: 11
      prefix: --lazy
outputs:
  - id: extracted_fasta
    type: File
    doc: Extracted fasta sequences.
    outputBinding:
      glob: $(inputs.outfile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/extract_fasta_seq:0.0.1--py_0
