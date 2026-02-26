cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - callingcardstools
  - legacy_makeccf
label: callingcardstools_legacy_makeccf
doc: "Converts alignment files to calling card format.\n\nTool homepage: https://github.com/cmatKhan/callingCardsTools"
inputs:
  - id: input_file
    type: File
    doc: Input alignment file (e.g., SAM, BAM, CRAM).
    inputBinding:
      position: 1
  - id: max_insert_size
    type:
      - 'null'
      - int
    doc: Maximum insert size to consider for paired-end reads.
    default: 1000
    inputBinding:
      position: 102
      prefix: --max_insert_size
  - id: min_baseq
    type:
      - 'null'
      - int
    doc: Minimum base quality to consider a base for calling card generation.
    default: 20
    inputBinding:
      position: 102
      prefix: --min_baseq
  - id: min_insert_size
    type:
      - 'null'
      - int
    doc: Minimum insert size to consider for paired-end reads.
    default: 0
    inputBinding:
      position: 102
      prefix: --min_insert_size
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality to consider a read for calling card generation.
    default: 20
    inputBinding:
      position: 102
      prefix: --min_mapq
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Prefix for the output calling card files.
    default: ccf
    inputBinding:
      position: 102
      prefix: --output_prefix
  - id: skip_duplicates
    type:
      - 'null'
      - boolean
    doc: Skip duplicate reads.
    inputBinding:
      position: 102
      prefix: --skip_duplicates
  - id: skip_low_quality
    type:
      - 'null'
      - boolean
    doc: Skip reads with low mapping quality or base quality.
    inputBinding:
      position: 102
      prefix: --skip_low_quality
  - id: skip_secondary
    type:
      - 'null'
      - boolean
    doc: Skip secondary alignments.
    inputBinding:
      position: 102
      prefix: --skip_secondary
  - id: skip_unmapped
    type:
      - 'null'
      - boolean
    doc: Skip unmapped reads.
    inputBinding:
      position: 102
      prefix: --skip_unmapped
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for processing.
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: outputpath
    type: Directory
    doc: Path to the output directory for calling card files.
    outputBinding:
      glob: $(inputs.outputpath)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/callingcardstools:1.8.1--pyhdfd78af_0
