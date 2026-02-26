cwlVersion: v1.2
class: CommandLineTool
baseCommand: STRcount
label: strcount_STRcount
doc: "STRcount: A tool for counting short tandem repeats in sequencing data.\n\nTool
  homepage: https://github.com/sabiqali/strcount"
inputs:
  - id: cleanup
    type:
      - 'null'
      - string
    doc: do you want to clean up the temporary file?
    inputBinding:
      position: 101
      prefix: --cleanup
  - id: config
    type: File
    doc: the config file
    inputBinding:
      position: 101
      prefix: --config
  - id: fastq
    type: File
    doc: the baseaclled reads in fastq format
    inputBinding:
      position: 101
      prefix: --fastq
  - id: min_aligned_fraction
    type:
      - 'null'
      - float
    doc: require alignments cover this proportion of the query sequence
    inputBinding:
      position: 101
      prefix: --min-aligned-fraction
  - id: min_identity
    type:
      - 'null'
      - float
    doc: only use reads with identity greater than this
    inputBinding:
      position: 101
      prefix: --min-identity
  - id: multiseed_dp
    type:
      - 'null'
      - string
    doc: Aligner option
    inputBinding:
      position: 101
      prefix: --multiseed-DP
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: the output directory for all output and temporary files
    inputBinding:
      position: 101
      prefix: --output_directory
  - id: precise_clipping
    type:
      - 'null'
      - string
    doc: 'Aligner option: use arg as the identity threshold for a valid alignment.'
    inputBinding:
      position: 101
      prefix: --precise-clipping
  - id: prefix_orientation
    type:
      - 'null'
      - string
    doc: the orientation of the prefix, + or -
    inputBinding:
      position: 101
      prefix: --prefix_orientation
  - id: reference
    type: File
    doc: the reference from which the STR Graph will be generated
    inputBinding:
      position: 101
      prefix: --reference
  - id: repeat_orientation
    type:
      - 'null'
      - string
    doc: the orientation of the repeat string. + or -
    inputBinding:
      position: 101
      prefix: --repeat_orientation
  - id: suffix_orientation
    type:
      - 'null'
      - string
    doc: the orientation of the suffix, + or -
    inputBinding:
      position: 101
      prefix: --suffix_orientation
  - id: write_non_spanned
    type:
      - 'null'
      - boolean
    doc: do not require the reads to span the prefix/suffix region
    inputBinding:
      position: 101
      prefix: --write-non-spanned
outputs:
  - id: output
    type: File
    doc: the output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strcount:0.1.1--py310h7cba7a3_1
