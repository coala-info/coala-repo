cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- fasta
label: samtools_fasta
doc: 'Convert a SAM, BAM or CRAM file to FASTA format


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: input_file
  type: File
  doc: Input SAM/BAM/CRAM file, collated by name.
  inputBinding:
    position: 104
- id: other_reads_file
  type:
  - 'null'
  - string
  doc: Write reads designated READ_OTHER to this file (-0).
  inputBinding:
    position: 103
    prefix: '-0'
- id: read1_file
  type:
  - 'null'
  - string
  doc: Write reads designated READ1 to this file (-1).
  inputBinding:
    position: 103
    prefix: '-1'
- id: read2_file
  type:
  - 'null'
  - string
  doc: Write reads designated READ2 to this file (-2).
  inputBinding:
    position: 103
    prefix: '-2'
- id: output_file
  type:
  - 'null'
  - string
  doc: Write reads designated READ1 or READ2 to this file (-o).
  inputBinding:
    position: 103
    prefix: -o
- id: tag
  type:
  - 'null'
  - string
  doc: Only include reads containing TAG, optionally with value, as TAG[:VAL].
  inputBinding:
    position: 103
    prefix: --tag
- id: tag_file
  type:
  - 'null'
  - File
  doc: File of values for the tag named by tag_file_tag.
  inputBinding:
    position: 103
    prefix: --tag-file
    valueFrom: $(inputs.tag_file_tag):$(self.path)
- id: tag_file_tag
  type:
  - 'null'
  - string
  doc: Tag name used with tag_file (STR:FILE).
- id: require_flags
  type:
  - 'null'
  - string
  doc: Only include reads with all of the FLAGs present [0].
  inputBinding:
    position: 103
    prefix: --require-flags
- id: exclude_flags
  type:
  - 'null'
  - string
  doc: Only include reads with none of the FLAGs present [0x900].
  inputBinding:
    position: 103
    prefix: --excl-flags
- id: include_flags
  type:
  - 'null'
  - string
  doc: Only include reads with any of the FLAGs present [0].
  inputBinding:
    position: 103
    prefix: --incl-flags
- id: exclude_all_flags
  type:
  - 'null'
  - string
  doc: Only EXCLUDE reads with all of the FLAGs present [0].
  inputBinding:
    position: 103
    prefix: -G
- id: no_suffix
  type:
  - 'null'
  - boolean
  doc: Do not append /1 and /2 to the read name.
  inputBinding:
    position: 103
    prefix: -n
- id: always_suffix
  type:
  - 'null'
  - boolean
  doc: Always append /1 and /2 to the read name.
  inputBinding:
    position: 103
    prefix: -N
- id: no_sc
  type:
  - 'null'
  - boolean
  doc: Remove soft-clips from output.
  inputBinding:
    position: 103
    prefix: --no-sc
- id: sc_aux
  type:
  - 'null'
  - string
  doc: Tag with which to backup the removed soft-clip data [s0].
  inputBinding:
    position: 103
    prefix: --sc-aux
- id: no_sc_bkp
  type:
  - 'null'
  - boolean
  doc: Do not backup removed soft-clips as aux tags.
  inputBinding:
    position: 103
    prefix: --no-sc-bkp
- id: singleton_file
  type:
  - 'null'
  - string
  doc: Write singleton reads designated READ1 or READ2 to this file (-s).
  inputBinding:
    position: 103
    prefix: -s
- id: copy_rg_bc_qt
  type:
  - 'null'
  - boolean
  doc: Copy RG, BC and QT tags to the header line.
  inputBinding:
    position: 103
    prefix: -t
- id: copy_tags
  type:
  - 'null'
  - string
  doc: Copy arbitrary tags to the header line, '*' for all (-T).
  inputBinding:
    position: 103
    prefix: -T
- id: casava
  type:
  - 'null'
  - boolean
  doc: Add Illumina Casava 1.8 format entry to header (e.g. 1:N:0:ATCACG).
  inputBinding:
    position: 103
    prefix: -i
- id: umi
  type:
  - 'null'
  - boolean
  doc: Add UMI to read name.
  inputBinding:
    position: 103
    prefix: --UMI
- id: umi_tag
  type:
  - 'null'
  - string
  doc: The list of aux tags to search for UMI barcode [RX,OX].
  inputBinding:
    position: 103
    prefix: --UMI-tag
- id: compression_level
  type:
  - 'null'
  - int
  doc: Compression level [0..9] to use when writing bgzf files [1].
  inputBinding:
    position: 103
    prefix: -c
- id: i1_file
  type:
  - 'null'
  - string
  doc: Write first index reads to this file.
  inputBinding:
    position: 103
    prefix: --i1
- id: i2_file
  type:
  - 'null'
  - string
  doc: Write second index reads to this file.
  inputBinding:
    position: 103
    prefix: --i2
- id: barcode_tag
  type:
  - 'null'
  - string
  doc: Barcode tag [BC].
  inputBinding:
    position: 103
    prefix: --barcode-tag
- id: index_format
  type:
  - 'null'
  - string
  doc: How to parse barcode and quality tags, e.g. i14i8.
  inputBinding:
    position: 103
    prefix: --index-format
- id: reference
  type:
  - 'null'
  - File
  doc: Reference sequence FASTA file.
  secondaryFiles:
  - pattern: .fai
    required: false
  inputBinding:
    position: 103
    prefix: --reference
- id: threads
  type:
  - 'null'
  - int
  doc: Number of additional threads to use [0].
  inputBinding:
    position: 103
    prefix: --threads
- id: verbosity
  type:
  - 'null'
  - int
  doc: Set level of verbosity.
  inputBinding:
    position: 103
    prefix: --verbosity
- id: stdout_name
  type: string
  doc: Name of the file that receives standard output (reads not sent to a named file).
  default: stdout_reads.fa
- id: input_fmt_option
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --input-fmt-option
  doc: Specify a single input file format option in the form OPTION or OPTION=VALUE (repeatable).
  inputBinding:
    position: 103
outputs:
- id: stdout_output
  type: File
  doc: Reads written to standard output.
  outputBinding:
    glob: $(inputs.stdout_name)
- id: output_other_reads
  type:
  - 'null'
  - File
  doc: READ_OTHER reads.
  outputBinding:
    glob: $(inputs.other_reads_file)
- id: output_read1
  type:
  - 'null'
  - File
  doc: READ1 reads.
  outputBinding:
    glob: $(inputs.read1_file)
- id: output_read2
  type:
  - 'null'
  - File
  doc: READ2 reads.
  outputBinding:
    glob: $(inputs.read2_file)
- id: output_reads
  type:
  - 'null'
  - File
  doc: READ1 and READ2 reads (-o).
  outputBinding:
    glob: $(inputs.output_file)
- id: output_singleton
  type:
  - 'null'
  - File
  doc: Singleton reads.
  outputBinding:
    glob: $(inputs.singleton_file)
- id: output_i1
  type:
  - 'null'
  - File
  doc: First index reads.
  outputBinding:
    glob: $(inputs.i1_file)
- id: output_i2
  type:
  - 'null'
  - File
  doc: Second index reads.
  outputBinding:
    glob: $(inputs.i2_file)
stdout: $(inputs.stdout_name)
