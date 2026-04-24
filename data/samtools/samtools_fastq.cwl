cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- fastq
label: samtools_fastq
doc: "Converts a SAM, BAM or CRAM to FASTQ format.\n\nTool homepage: https://github.com/samtools/samtools"
requirements:
- class: InlineJavascriptRequirement
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
  inputBinding:
    position: 102
    prefix: -c
- id: copy_arbitrary_tags
  type:
  - 'null'
  - string
  doc: copy arbitrary tags to the FASTQ header line, '*' for all
  inputBinding:
    position: 102
    prefix: -T
- id: copy_tags_to_header
  type:
  - 'null'
  - boolean
  doc: copy RG, BC and QT tags to the FASTQ header line
  inputBinding:
    position: 102
    prefix: -t
- id: default_quality
  type:
  - 'null'
  - int
  doc: default quality score if not given in file
  inputBinding:
    position: 102
    prefix: -v
- id: exclude_all_flags
  type:
  - 'null'
  - int
  doc: only EXCLUDE reads with all of the FLAGs in INT present
  inputBinding:
    position: 102
    prefix: -G
- id: exclude_flags
  type:
  - 'null'
  - string
  doc: only include reads with none of the FLAGs in INT present
  inputBinding:
    position: 102
    prefix: --excl-flags
- id: include_flags
  type:
  - 'null'
  - int
  doc: only include reads with any of the FLAGs in INT present
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
- id: no_soft_clip_backup
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
- id: output_quality_oq
  type:
  - 'null'
  - boolean
  doc: output quality in the OQ tag if present
  inputBinding:
    position: 102
    prefix: -O
- id: quality_tag
  type:
  - 'null'
  - string
  doc: Quality tag
  inputBinding:
    position: 102
    prefix: --quality-tag
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
  inputBinding:
    position: 102
    prefix: --require-flags
- id: soft_clip_aux_tag
  type:
  - 'null'
  - string
  doc: Tag with which to backup the removed soft-clip data
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
  - string
  doc: only include reads containing TAG, with a value listed in FILE
  inputBinding:
    position: 102
    prefix: --tag-file
- id: threads
  type:
  - 'null'
  - int
  doc: Number of additional threads to use
  inputBinding:
    position: 102
    prefix: --threads
- id: umi_tag
  type:
  - 'null'
  - string
  doc: the list of aux tags to search for UMI barcode
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
- id: read_other_file_name
  type: string?
  inputBinding:
    position: 102
    prefix: '0'
- id: read1_file_name
  type: string?
  inputBinding:
    position: 102
    prefix: '-1'
- id: read2_file_name
  type: string?
  inputBinding:
    position: 102
    prefix: '-2'
- id: output_file_name
  type: string?
  inputBinding:
    position: 102
    prefix: -o
- id: singleton_file_name
  type: string?
  inputBinding:
    position: 102
    prefix: -s
- id: index1_file_name
  type: string?
  inputBinding:
    position: 102
    prefix: --index1
- id: index2_file_name
  type: string?
  inputBinding:
    position: 102
    prefix: --index2
outputs:
- id: read_other_file
  type: File?
  outputBinding:
    glob: $(inputs.read_other_file_name)
- id: read1_file
  type: File?
  outputBinding:
    glob: $(inputs.read1_file_name)
- id: read2_file
  type: File?
  outputBinding:
    glob: $(inputs.read2_file_name)
- id: output_file
  type: File?
  outputBinding:
    glob: $(inputs.output_file_name)
- id: singleton_file
  type: File?
  outputBinding:
    glob: $(inputs.singleton_file_name)
- id: index1_file
  type: File?
  outputBinding:
    glob: $(inputs.index1_file_name)
- id: index2_file
  type: File?
  outputBinding:
    glob: $(inputs.index2_file_name)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
