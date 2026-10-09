cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - matlock
  - bamfilt
label: matlock_bamfilt
doc: "Filter a Hi-C BAM (mate pairs with low mapping quality, high edit distance,
  duplicates, unmapped reads and more are removed). The tool crashes when -x is not
  given, so the wrapper passes an empty exclude list by default.\n\nTool homepage:
  https://github.com/phasegenomics/matlock"
inputs:
  - id: input
    type: File
    doc: Input file (cram, bam or sam).
    inputBinding:
      position: 101
      prefix: -i
  - id: output_path
    type: string
    doc: Output file (bam).
    inputBinding:
      position: 102
      prefix: -o
  - id: mapq
    type:
      - 'null'
      - int
    doc: MapQ filter. [20]
    inputBinding:
      position: 103
      prefix: -m
  - id: edit_distance
    type:
      - 'null'
      - int
    doc: Max edit distance. [5]
    inputBinding:
      position: 103
      prefix: -e
  - id: min_target_length
    type:
      - 'null'
      - int
    doc: Min target seq-length. [0]
    inputBinding:
      position: 103
      prefix: -l
  - id: exclude
    type: string
    default: ''
    doc: Comma separated list of seqids to exclude/include (or a file with the
      list). Use with the binary flag 64 (-f 64). An empty list is the default.
    inputBinding:
      position: 103
      prefix: -x
  - id: include
    type:
      - 'null'
      - boolean
    doc: Include the seqids of -x rather than exclude them.
    inputBinding:
      position: 103
      prefix: -y
  - id: flag_filter
    type:
      - 'null'
      - int
    doc: "Binary flag filter: SAME_SEQID = 2, LOW_MAPQ = 4, XA_SA = 8, NM = 16,
      SMALLCONTIG = 32, EXCLUDE = 64, SA_ONLY = 128, UNMAPPED = 256, DUPLICATE =
      1024. The default is 1300 = LOW_MAPQ | NM | DUPLICATE | UNMAPPED."
    inputBinding:
      position: 103
      prefix: -f
outputs:
  - id: output
    type: File
    doc: Filtered BAM file
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/matlock:20181227--h665f8ca_8
