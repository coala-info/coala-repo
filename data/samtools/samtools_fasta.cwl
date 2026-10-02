cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - fasta
label: samtools_fasta
doc: Converts a SAM, BAM or CRAM to FASTA format.
inputs:
  - id: input_file
    type: File
    doc: Input SAM, BAM or CRAM file
    inputBinding:
      position: 1
  - id: other_reads_file
    type:
      - 'null'
      - string
    doc: write reads designated READ_OTHER to FILE
    inputBinding:
      position: 102
      prefix: '-0'
  - id: read1_file
    type:
      - 'null'
      - string
    doc: write reads designated READ1 to FILE
    inputBinding:
      position: 102
      prefix: '-1'
  - id: read2_file
    type:
      - 'null'
      - string
    doc: write reads designated READ2 to FILE
    inputBinding:
      position: 102
      prefix: '-2'
  - id: output_file
    type:
      - 'null'
      - string
    doc: 'write reads designated READ1 or READ2 to FILE note: if a singleton file
      is specified with -s, only paired reads will be written to the -1 and -2 files.'
    inputBinding:
      position: 102
      prefix: -o
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
      - string
    doc: only include reads containing TAG, with a value listed in FILE
    inputBinding:
      position: 102
      prefix: --tag-file
  - id: require_flags
    type:
      - 'null'
      - string
    doc: only include reads with all of the FLAGs in INT present [0]
    inputBinding:
      position: 102
      prefix: --require-flags
  - id: exclude_flags
    type:
      - 'null'
      - string
    doc: only include reads with none of the FLAGs in INT present [0x900]
    inputBinding:
      position: 102
      prefix: --excl-flags
  - id: include_flags
    type:
      - 'null'
      - string
    doc: only include reads with any of the FLAGs in INT present [0]
    inputBinding:
      position: 102
      prefix: --incl-flags
  - id: exclude_all_flags
    type:
      - 'null'
      - string
    doc: only EXCLUDE reads with all of the FLAGs in INT present [0]
    inputBinding:
      position: 102
      prefix: -G
  - id: no_append_read_number
    type:
      - 'null'
      - boolean
    doc: don't append /1 and /2 to the read name
    inputBinding:
      position: 102
      prefix: -n
  - id: always_append_read_number
    type:
      - 'null'
      - boolean
    doc: always append /1 and /2 to the read name
    inputBinding:
      position: 102
      prefix: -N
  - id: no_sc
    type:
      - 'null'
      - boolean
    doc: Remove soft-clips from output
    inputBinding:
      position: 102
      prefix: --no-sc
  - id: sc_aux
    type:
      - 'null'
      - string
    doc: Tag with which to backup the removed soft-clip data [s0]
    inputBinding:
      position: 102
      prefix: --sc-aux
  - id: no_sc_bkp
    type:
      - 'null'
      - boolean
    doc: Do not backup removed soft-clips as aux tags
    inputBinding:
      position: 102
      prefix: --no-sc-bkp
  - id: singleton_file
    type:
      - 'null'
      - string
    doc: write singleton reads designated READ1 or READ2 to FILE
    inputBinding:
      position: 102
      prefix: -s
  - id: copy_default_tags
    type:
      - 'null'
      - boolean
    doc: copy RG, BC and QT tags to the FASTA header line
    inputBinding:
      position: 102
      prefix: -t
  - id: copy_tags
    type:
      - 'null'
      - string
    doc: copy arbitrary tags to the FASTA header line, '*' for all
    inputBinding:
      position: 102
      prefix: -T
  - id: casava
    type:
      - 'null'
      - boolean
    doc: add Illumina Casava 1.8 format entry to header (eg 1:N:0:ATCACG)
    inputBinding:
      position: 102
      prefix: -i
  - id: umi
    type:
      - 'null'
      - boolean
    doc: add UMI to read name
    inputBinding:
      position: 102
      prefix: --UMI
  - id: umi_tag
    type:
      - 'null'
      - string
    doc: the list of aux tags to search for UMI barcode [RX,OX]
    inputBinding:
      position: 102
      prefix: --UMI-tag
  - id: compression_level
    type:
      - 'null'
      - int
    doc: compression level [0..9] to use when writing bgzf files [1]
    inputBinding:
      position: 102
      prefix: -c
  - id: i1_file
    type:
      - 'null'
      - string
    doc: write first index reads to FILE
    inputBinding:
      position: 102
      prefix: --i1
  - id: i2_file
    type:
      - 'null'
      - string
    doc: write second index reads to FILE
    inputBinding:
      position: 102
      prefix: --i2
  - id: barcode_tag
    type:
      - 'null'
      - string
    doc: Barcode tag [BC]
    inputBinding:
      position: 102
      prefix: --barcode-tag
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
      - string
    doc: Specify a single input file format option in the form of OPTION or 
      OPTION=VALUE
    inputBinding:
      position: 102
      prefix: --input-fmt-option
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference sequence FASTA FILE [null]
    secondaryFiles:
      - .fai
    inputBinding:
      position: 102
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of additional threads to use [0]
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_other_reads_file
    type:
      - 'null'
      - File
    doc: write reads designated READ_OTHER to FILE
    outputBinding:
      glob: $(inputs.other_reads_file)
  - id: output_read1_file
    type:
      - 'null'
      - File
    doc: write reads designated READ1 to FILE
    outputBinding:
      glob: $(inputs.read1_file)
  - id: output_read2_file
    type:
      - 'null'
      - File
    doc: write reads designated READ2 to FILE
    outputBinding:
      glob: $(inputs.read2_file)
  - id: output_output_file
    type:
      - 'null'
      - File
    doc: 'write reads designated READ1 or READ2 to FILE note: if a singleton file
      is specified with -s, only paired reads will be written to the -1 and -2 files.'
    outputBinding:
      glob: $(inputs.output_file)
  - id: output_singleton_file
    type:
      - 'null'
      - File
    doc: write singleton reads designated READ1 or READ2 to FILE
    outputBinding:
      glob: $(inputs.singleton_file)
  - id: output_i1_file
    type:
      - 'null'
      - File
    doc: write first index reads to FILE
    outputBinding:
      glob: $(inputs.i1_file)
  - id: output_i2_file
    type:
      - 'null'
      - File
    doc: write second index reads to FILE
    outputBinding:
      glob: $(inputs.i2_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
s:url: https://github.com/samtools/samtools
$namespaces:
  s: https://schema.org/
