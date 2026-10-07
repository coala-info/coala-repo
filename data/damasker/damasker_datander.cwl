cwlVersion: v1.2
class: CommandLineTool
baseCommand: datander
label: damasker_datander
doc: "Find tandem repeats: compare each read of a DAZZ_DB block with itself and
  write the self alignments to TAN.<subject>.las in the working directory.\n\nTool
  homepage: https://github.com/thegenemyers/DAMASKER"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode, output statistics as proceed.
    inputBinding:
      position: 1
      prefix: -v
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size (must be <= 32). Default 12.
    inputBinding:
      position: 1
      prefix: -k
      separate: false
  - id: band_width
    type:
      - 'null'
      - int
    doc: Look for k-mers in averlapping bands of size 2^-w. Default 4.
    inputBinding:
      position: 1
      prefix: -w
      separate: false
  - id: seed_hit_threshold
    type:
      - 'null'
      - int
    doc: A seed hit if the k-mers in band cover >= -h bps in the targest read. Default 35.
    inputBinding:
      position: 1
      prefix: -h
      separate: false
  - id: threads
    type:
      - 'null'
      - int
    doc: Use -T threads. Default 4.
    inputBinding:
      position: 1
      prefix: -T
      separate: false
  - id: sort_merge_dir
    type:
      - 'null'
      - string
    doc: Do first level sort and merge in directory -P. Default /tmp.
    inputBinding:
      position: 1
      prefix: -P
      separate: false
  - id: similarity_threshold
    type:
      - 'null'
      - double
    doc: Look for alignments with -e percent similarity. Default .70.
    inputBinding:
      position: 1
      prefix: -e
      separate: false
  - id: min_alignment_length
    type:
      - 'null'
      - int
    doc: Look for alignments of length >= -l. Default 500.
    inputBinding:
      position: 1
      prefix: -l
      separate: false
  - id: trace_point_spacing
    type:
      - 'null'
      - int
    doc: Use -s as the trace point spacing for encoding alignments. Default 100.
    inputBinding:
      position: 1
      prefix: -s
      separate: false
  - id: subject_db
    type:
      type: array
      items: File
    doc: Subject database(s) or blocks (.db or .dam)
    inputBinding:
      position: 2
    secondaryFiles:
      - pattern: '${ return "." + self.nameroot + ".idx"; }'
      - pattern: '${ return "." + self.nameroot + ".bps"; }'
      - pattern: '${ return "." + self.nameroot + ".hdr"; }'
        required: false
outputs:
  - id: tandem_alignments
    type:
      type: array
      items: File
    doc: Tandem self-alignment files (TAN.<subject>.las)
    outputBinding:
      glob: TAN.*.las
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/damasker:1.0p1--h7b50bb2_8
