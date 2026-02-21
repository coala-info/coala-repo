cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bbmerge.sh
label: bbmap_bbmerge
doc: "Merges paired reads into single reads by overlap detection. With sufficient
  coverage, can merge nonoverlapping reads by kmer extension.\n\nTool homepage: https://sourceforge.net/projects/bbmap"
inputs:
  - id: adapter
    type:
      - 'null'
      - string
    doc: Specify the adapter sequences used for these reads; can be a fasta file or
      literal sequence.
    inputBinding:
      position: 101
      prefix: adapter
  - id: cutoff
    type:
      - 'null'
      - float
    doc: Merge reads with nn score above this value.
    default: 0.872857
    inputBinding:
      position: 101
      prefix: cutoff
  - id: extend
    type:
      - 'null'
      - int
    doc: Extend reads to the right this much before merging.
    default: 0
    inputBinding:
      position: 101
      prefix: extend
  - id: extra
    type:
      - 'null'
      - type: array
        items: File
    doc: A file or comma-delimited list of files of reads to use for kmer counting.
    inputBinding:
      position: 101
      prefix: extra
  - id: forcetrimleft
    type:
      - 'null'
      - int
    doc: If nonzero, trim left bases of the read to this position.
    default: 0
    inputBinding:
      position: 101
      prefix: forcetrimleft
  - id: forcetrimright
    type:
      - 'null'
      - int
    doc: If nonzero, trim right bases of the read after this position.
    default: 0
    inputBinding:
      position: 101
      prefix: forcetrimright
  - id: in
    type: File
    doc: Primary input. 'in2' will specify a second file.
    inputBinding:
      position: 101
      prefix: in
  - id: in2
    type:
      - 'null'
      - File
    doc: Second input file for twin files mode.
    inputBinding:
      position: 101
      prefix: in2
  - id: interleaved
    type:
      - 'null'
      - string
    doc: May be set to true or false to override autodetection of whether the input
      file as interleaved.
    default: auto
    inputBinding:
      position: 101
      prefix: interleaved
  - id: k
    type:
      - 'null'
      - int
    doc: Kmer length.
    default: 31
    inputBinding:
      position: 101
      prefix: k
  - id: maxexpectederrors
    type:
      - 'null'
      - float
    doc: If positive, reads with more combined expected errors than this will not
      be attempted to be merged.
    default: 0
    inputBinding:
      position: 101
      prefix: maxexpectederrors
  - id: maxlength
    type:
      - 'null'
      - int
    doc: Reads with longer insert sizes will be discarded.
    default: -1
    inputBinding:
      position: 101
      prefix: maxlength
  - id: merge
    type:
      - 'null'
      - boolean
    doc: Create merged reads.
    default: true
    inputBinding:
      position: 101
      prefix: merge
  - id: minavgquality
    type:
      - 'null'
      - int
    doc: Reads with average quality below this will not be attempted to be merged.
    default: 0
    inputBinding:
      position: 101
      prefix: minavgquality
  - id: mininsert
    type:
      - 'null'
      - int
    doc: Minimum insert size to merge reads.
    default: 15
    inputBinding:
      position: 101
      prefix: mininsert
  - id: minlength
    type:
      - 'null'
      - int
    doc: Reads shorter than this after trimming will be discarded.
    default: 1
    inputBinding:
      position: 101
      prefix: minlength
  - id: minoverlap
    type:
      - 'null'
      - int
    doc: Minimum number of overlapping bases to allow merging.
    default: 12
    inputBinding:
      position: 101
      prefix: minoverlap
  - id: mix
    type:
      - 'null'
      - boolean
    doc: Output both the merged (or mergable) and unmerged reads in the same file
      (out=).
    default: false
    inputBinding:
      position: 101
      prefix: mix
  - id: nn
    type:
      - 'null'
      - boolean
    doc: Use a neural network for increased merging accuracy.
    default: true
    inputBinding:
      position: 101
      prefix: nn
  - id: nzo
    type:
      - 'null'
      - boolean
    doc: Only print histogram bins with nonzero values.
    default: true
    inputBinding:
      position: 101
      prefix: nzo
  - id: ordered
    type:
      - 'null'
      - boolean
    doc: Output reads in same order as input.
    default: false
    inputBinding:
      position: 101
      prefix: ordered
  - id: qtrim
    type:
      - 'null'
      - string
    doc: 'Trim read ends to remove bases with quality below minq. Values: t, f, r,
      l.'
    default: f
    inputBinding:
      position: 101
      prefix: qtrim
  - id: reads
    type:
      - 'null'
      - int
    doc: Quit after this many read pairs (-1 means all).
    default: -1
    inputBinding:
      position: 101
      prefix: reads
  - id: showhiststats
    type:
      - 'null'
      - boolean
    doc: Print extra header lines with statistical information.
    default: true
    inputBinding:
      position: 101
      prefix: showhiststats
  - id: strict
    type:
      - 'null'
      - boolean
    doc: Decrease false positive rate and merging rate.
    default: false
    inputBinding:
      position: 101
      prefix: strict
  - id: tbo
    type:
      - 'null'
      - boolean
    doc: Trim overlapping reads to remove rightmost (3') non-overlapping portion.
    default: false
    inputBinding:
      position: 101
      prefix: tbo
  - id: trimq
    type:
      - 'null'
      - string
    doc: Trim quality threshold. This may be a comma-delimited list.
    default: '10'
    inputBinding:
      position: 101
      prefix: trimq
  - id: ziplevel
    type:
      - 'null'
      - int
    doc: Set to 1 (lowest) through 9 (max) to change compression level.
    default: 2
    inputBinding:
      position: 101
      prefix: ziplevel
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: File for merged reads. 'out2' will specify a second file.
    outputBinding:
      glob: $(inputs.out)
  - id: out2
    type:
      - 'null'
      - File
    doc: Second file for merged reads.
    outputBinding:
      glob: $(inputs.out2)
  - id: outu
    type:
      - 'null'
      - File
    doc: File for unmerged reads. 'outu2' will specify a second file.
    outputBinding:
      glob: $(inputs.outu)
  - id: outu2
    type:
      - 'null'
      - File
    doc: Second file for unmerged reads.
    outputBinding:
      glob: $(inputs.outu2)
  - id: outinsert
    type:
      - 'null'
      - File
    doc: File to write read names and insert sizes.
    outputBinding:
      glob: $(inputs.outinsert)
  - id: outadapter
    type:
      - 'null'
      - File
    doc: File to write consensus adapter sequences.
    outputBinding:
      glob: $(inputs.outadapter)
  - id: outc
    type:
      - 'null'
      - File
    doc: File to write input read kmer cardinality estimate.
    outputBinding:
      glob: $(inputs.outc)
  - id: ihist
    type:
      - 'null'
      - File
    doc: Insert length histogram output file.
    outputBinding:
      glob: $(inputs.ihist)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bbmap:39.52--he5f24ec_0
