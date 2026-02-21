cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - fasta
label: samtools_fasta
doc: "Converts a SAM, BAM or CRAM to FASTA format.\n\nTool homepage: https://github.com/samtools/samtools"
inputs:
  - id: input_file
    type: File
    doc: Input SAM, BAM or CRAM file
    inputBinding:
      position: 1
  - id: add_umi
    type:
      - 'null'
      - boolean
    doc: add UMI to read name
    inputBinding:
      position: 102
      prefix: --UMI
  - id: always_append_suffix
    type:
      - 'null'
      - boolean
    doc: always append /1 and /2 to the read name
    inputBinding:
      position: 102
      prefix: -N
  - id: barcode_tag
    type:
      - 'null'
      - string
    doc: Barcode tag
    default: BC
    inputBinding:
      position: 102
      prefix: --barcode-tag
  - id: casava_format
    type:
      - 'null'
      - boolean
    doc: add Illumina Casava 1.8 format entry to header (eg 1:N:0:ATCACG)
    inputBinding:
      position: 102
      prefix: -i
  - id: compression_level
    type:
      - 'null'
      - int
    doc: compression level [0..9] to use when writing bgzf files
    default: 1
    inputBinding:
      position: 102
      prefix: -c
  - id: copy_arbitrary_tags
    type:
      - 'null'
      - string
    doc: copy arbitrary tags to the FASTA header line, '*' for all
    inputBinding:
      position: 102
      prefix: -T
  - id: copy_tags_header
    type:
      - 'null'
      - boolean
    doc: copy RG, BC and QT tags to the FASTA header line
    inputBinding:
      position: 102
      prefix: -t
  - id: exclude_all_flags
    type:
      - 'null'
      - int
    doc: only EXCLUDE reads with all of the FLAGs in INT present
    default: 0
    inputBinding:
      position: 102
      prefix: -G
  - id: exclude_flags
    type:
      - 'null'
      - int
    doc: only include reads with none of the FLAGs in INT present
    default: '0x900'
    inputBinding:
      position: 102
      prefix: --excl-flags
  - id: include_flags
    type:
      - 'null'
      - int
    doc: only include reads with any of the FLAGs in INT present
    default: 0
    inputBinding:
      position: 102
      prefix: --incl-flags
  - id: index_format
    type:
      - 'null'
      - string
    doc: How to parse barcode and quality tags
    inputBinding:
      position: 102
      prefix: --index-format
  - id: input_fmt_option
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify a single input file format option in the form of OPTION or 
      OPTION=VALUE
    inputBinding:
      position: 102
      prefix: --input-fmt-option
  - id: no_append_suffix
    type:
      - 'null'
      - boolean
    doc: don't append /1 and /2 to the read name
    inputBinding:
      position: 102
      prefix: -n
  - id: no_sc_backup
    type:
      - 'null'
      - boolean
    doc: Do not backup removed soft-clips as aux tags
    inputBinding:
      position: 102
      prefix: --no-sc-bkp
  - id: no_soft_clips
    type:
      - 'null'
      - boolean
    doc: Remove soft-clips from output
    inputBinding:
      position: 102
      prefix: --no-sc
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference sequence FASTA FILE
    inputBinding:
      position: 102
      prefix: --reference
  - id: require_flags
    type:
      - 'null'
      - int
    doc: only include reads with all of the FLAGs in INT present
    default: 0
    inputBinding:
      position: 102
      prefix: --require-flags
  - id: sc_aux_tag
    type:
      - 'null'
      - string
    doc: Tag with which to backup the removed soft-clip data
    default: s0
    inputBinding:
      position: 102
      prefix: --sc-aux
  - id: tag
    type:
      - 'null'
      - string
    doc: only include reads containing TAG, optionally with value VAL
    inputBinding:
      position: 102
      prefix: --tag
  - id: tag_file
    type:
      - 'null'
      - File
    doc: only include reads containing TAG, with a value listed in FILE
    inputBinding:
      position: 102
      prefix: --tag-file
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of additional threads to use
    default: 0
    inputBinding:
      position: 102
      prefix: --threads
  - id: umi_tag
    type:
      - 'null'
      - string
    doc: the list of aux tags to search for UMI barcode
    default: RX,OX
    inputBinding:
      position: 102
      prefix: --UMI-tag
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Set level of verbosity
    inputBinding:
      position: 102
      prefix: --verbosity
outputs:
  - id: read_other_out
    type:
      - 'null'
      - File
    doc: write reads designated READ_OTHER to FILE
    outputBinding:
      glob: $(inputs.read_other_out)
  - id: read1_out
    type:
      - 'null'
      - File
    doc: write reads designated READ1 to FILE
    outputBinding:
      glob: $(inputs.read1_out)
  - id: read2_out
    type:
      - 'null'
      - File
    doc: write reads designated READ2 to FILE
    outputBinding:
      glob: $(inputs.read2_out)
  - id: output_file
    type:
      - 'null'
      - File
    doc: write reads designated READ1 or READ2 to FILE
    outputBinding:
      glob: $(inputs.output_file)
  - id: singleton_out
    type:
      - 'null'
      - File
    doc: write singleton reads designated READ1 or READ2 to FILE
    outputBinding:
      glob: $(inputs.singleton_out)
  - id: index1_out
    type:
      - 'null'
      - File
    doc: write first index reads to FILE
    outputBinding:
      glob: $(inputs.index1_out)
  - id: index2_out
    type:
      - 'null'
      - File
    doc: write second index reads to FILE
    outputBinding:
      glob: $(inputs.index2_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
