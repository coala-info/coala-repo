cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - daligner
label: daligner
doc: "Find all significant local alignments between the reads of a subject DAZZ_DB
  block and one or more target blocks. The result is one sorted .las file per
  subject/target pair (<subject>.<target>.las) in the working directory.\n\nTool
  homepage: https://github.com/thegenemyers/DALIGNER"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode, output statistics as proceed.
    inputBinding:
      position: 101
      prefix: -v
  - id: sort_by_a_position
    type:
      - 'null'
      - boolean
    doc: Sort .las by A-read,A-position pairs for map usecase (off = sort by
      A,B-read pairs for overlap piles).
    inputBinding:
      position: 101
      prefix: -a
  - id: asymmetric
    type:
      - 'null'
      - boolean
    doc: Compare subject to target, but not vice versa.
    inputBinding:
      position: 101
      prefix: -A
  - id: bridge
    type:
      - 'null'
      - boolean
    doc: Bridge consecutive aligned segments into one if possible
    inputBinding:
      position: 101
      prefix: -B
  - id: identity_compare
    type:
      - 'null'
      - boolean
    doc: Compare reads to themselves
    inputBinding:
      position: 101
      prefix: -I
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size (must be <= 32). Default 16.
    inputBinding:
      position: 101
      prefix: -k
      separate: false
  - id: modimer_percentage
    type:
      - 'null'
      - int
    doc: Modimer percentage (take % of the k-mers). Default 28.
    inputBinding:
      position: 101
      prefix: -%
      separate: false
  - id: band_width
    type:
      - 'null'
      - int
    doc: Look for k-mers in averlapping bands of size 2^-w. Default 6.
    inputBinding:
      position: 101
      prefix: -w
      separate: false
  - id: hit_coverage
    type:
      - 'null'
      - int
    doc: A seed hit if the k-mers in band cover >= -h bps in the targest read.
      Default 50.
    inputBinding:
      position: 101
      prefix: -h
      separate: false
  - id: kmer_frequency_cutoff
    type:
      - 'null'
      - int
    doc: Ignore k-mers that occur >= -t times in a block.
    inputBinding:
      position: 101
      prefix: -t
      separate: false
  - id: memory_gb
    type:
      - 'null'
      - int
    doc: Use only -M GB of memory by ignoring most frequent k-mers.
    inputBinding:
      position: 101
      prefix: -M
      separate: false
  - id: min_identity
    type:
      - 'null'
      - double
    doc: Look for alignments with -e percent similarity. Default .75.
    inputBinding:
      position: 101
      prefix: -e
      separate: false
  - id: min_alignment_length
    type:
      - 'null'
      - int
    doc: Look for alignments of length >= -l. Default 1500.
    inputBinding:
      position: 101
      prefix: -l
      separate: false
  - id: trace_spacing
    type:
      - 'null'
      - int
    doc: The trace point spacing for encoding alignments. Default 100.
    inputBinding:
      position: 101
      prefix: -s
      separate: false
  - id: hgap_min_length
    type:
      - 'null'
      - int
    doc: 'HGAP option: align only target reads of length >= -H.'
    inputBinding:
      position: 101
      prefix: -H
      separate: false
  - id: threads
    type:
      - 'null'
      - int
    doc: Use -T threads. Default 4.
    inputBinding:
      position: 101
      prefix: -T
      separate: false
  - id: sort_dir
    type:
      - 'null'
      - string
    doc: Do block level sorts and merges in directory -P. Default /tmp.
    inputBinding:
      position: 101
      prefix: -P
      separate: false
  - id: mask_tracks
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -m
          separate: false
    doc: Soft mask the blocks with the specified mask track (for example dust
      or tan). The track files .<db>.<track>.anno and .<db>.<track>.data must
      sit beside the subject database.
    inputBinding:
      position: 101
  - id: subject
    type: File
    doc: Subject DAZZ_DB database or block (.db or .dam). Its hidden .idx and
      .bps files must sit beside it.
    inputBinding:
      position: 201
    secondaryFiles:
      - pattern: '${ return "." + self.nameroot + ".idx"; }'
      - pattern: '${ return "." + self.nameroot + ".bps"; }'
      - pattern: '${ return "." + self.nameroot + ".hdr"; }'
        required: false
      - pattern: '${ return "." + self.nameroot + ".dust.anno"; }'
        required: false
      - pattern: '${ return "." + self.nameroot + ".dust.data"; }'
        required: false
      - pattern: '${ return "." + self.nameroot + ".tan.anno"; }'
        required: false
      - pattern: '${ return "." + self.nameroot + ".tan.data"; }'
        required: false
  - id: targets
    type:
      type: array
      items: File
    doc: One or more target DAZZ_DB databases or blocks (.db or .dam).
    inputBinding:
      position: 202
    secondaryFiles:
      - pattern: '${ return "." + self.nameroot + ".idx"; }'
      - pattern: '${ return "." + self.nameroot + ".bps"; }'
      - pattern: '${ return "." + self.nameroot + ".hdr"; }'
        required: false
outputs:
  - id: alignments
    type:
      type: array
      items: File
    doc: Sorted local alignment files, one per subject/target pair
      (<subject>.<target>.las)
    outputBinding:
      glob: '*.las'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/daligner:2.0.20240118--h7b50bb2_0
