cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bamtools
  - filter
label: bamtools_filter
doc: "filters BAM file(s).\n\nTool homepage: https://github.com/pezmaster31/bamtools"
inputs:
  - id: alignment_flag
    type:
      - 'null'
      - int
    doc: keep reads with this *exact* alignment flag
    inputBinding:
      position: 101
      prefix: -alignmentFlag
  - id: force_compression
    type:
      - 'null'
      - boolean
    doc: if results are sent to stdout (like when piping to another tool), default
      behavior is to leave output uncompressed. Use this flag to override and force
      compression
    inputBinding:
      position: 101
      prefix: -forceCompression
  - id: in
    type:
      - 'null'
      - type: array
        items: File
    doc: the input BAM file(s) [stdin]
    inputBinding:
      position: 101
      prefix: -in
  - id: insert_size
    type:
      - 'null'
      - int
    doc: keep reads with insert size that matches pattern
    inputBinding:
      position: 101
      prefix: -insertSize
  - id: is_duplicate
    type:
      - 'null'
      - string
    doc: keep only alignments that are marked as duplicate?
    default: 'true'
    inputBinding:
      position: 101
      prefix: -isDuplicate
  - id: is_failed_qc
    type:
      - 'null'
      - string
    doc: keep only alignments that failed QC?
    default: 'true'
    inputBinding:
      position: 101
      prefix: -isFailedQC
  - id: is_first_mate
    type:
      - 'null'
      - string
    doc: keep only alignments marked as first mate?
    default: 'true'
    inputBinding:
      position: 101
      prefix: -isFirstMate
  - id: is_mapped
    type:
      - 'null'
      - string
    doc: keep only alignments that were mapped?
    default: 'true'
    inputBinding:
      position: 101
      prefix: -isMapped
  - id: is_mate_mapped
    type:
      - 'null'
      - string
    doc: keep only alignments with mates that mapped
    default: 'true'
    inputBinding:
      position: 101
      prefix: -isMateMapped
  - id: is_mate_reverse_strand
    type:
      - 'null'
      - string
    doc: keep only alignments with mate on reverse strand?
    default: 'true'
    inputBinding:
      position: 101
      prefix: -isMateReverseStrand
  - id: is_paired
    type:
      - 'null'
      - string
    doc: keep only alignments that were sequenced as paired?
    default: 'true'
    inputBinding:
      position: 101
      prefix: -isPaired
  - id: is_primary_alignment
    type:
      - 'null'
      - string
    doc: keep only alignments marked as primary?
    default: 'true'
    inputBinding:
      position: 101
      prefix: -isPrimaryAlignment
  - id: is_proper_pair
    type:
      - 'null'
      - string
    doc: keep only alignments that passed PE resolution?
    default: 'true'
    inputBinding:
      position: 101
      prefix: -isProperPair
  - id: is_reverse_strand
    type:
      - 'null'
      - string
    doc: keep only alignments on reverse strand?
    default: 'true'
    inputBinding:
      position: 101
      prefix: -isReverseStrand
  - id: is_second_mate
    type:
      - 'null'
      - string
    doc: keep only alignments marked as second mate?
    default: 'true'
    inputBinding:
      position: 101
      prefix: -isSecondMate
  - id: is_singleton
    type:
      - 'null'
      - string
    doc: keep only singletons
    default: 'true'
    inputBinding:
      position: 101
      prefix: -isSingleton
  - id: length
    type:
      - 'null'
      - int
    doc: keep reads with length that matches pattern
    inputBinding:
      position: 101
      prefix: -length
  - id: list
    type:
      - 'null'
      - File
    doc: the input BAM file list, one line per file
    inputBinding:
      position: 101
      prefix: -list
  - id: map_quality
    type:
      - 'null'
      - int
    doc: keep reads with map quality that matches pattern
    inputBinding:
      position: 101
      prefix: -mapQuality
  - id: name
    type:
      - 'null'
      - string
    doc: keep reads with name that matches pattern
    inputBinding:
      position: 101
      prefix: -name
  - id: query_bases
    type:
      - 'null'
      - string
    doc: keep reads with motif that matches pattern
    inputBinding:
      position: 101
      prefix: -queryBases
  - id: region
    type:
      - 'null'
      - string
    doc: only read data from this genomic region (see documentation for more details)
    inputBinding:
      position: 101
      prefix: -region
  - id: script
    type:
      - 'null'
      - File
    doc: the filter script file (see documentation for more details)
    inputBinding:
      position: 101
      prefix: -script
  - id: tag
    type:
      - 'null'
      - string
    doc: keep reads with this key=>value pair
    inputBinding:
      position: 101
      prefix: -tag
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: the output BAM file [stdout]
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamtools:2.5.3--he132191_0
