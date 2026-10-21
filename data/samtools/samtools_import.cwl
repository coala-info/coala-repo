cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- import
label: samtools_import
doc: 'Convert FASTA or FASTQ files to unaligned SAM/BAM/CRAM


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: fastq_files
  type:
  - 'null'
  - type: array
    items: File
  doc: Input FASTQ files; one file is interpreted as -s, -0 or -1 by content, a pair as -1 and -2.
  inputBinding:
    position: 104
- id: interleaved_fastq
  type:
  - 'null'
  - File
  doc: Read paired-ended data from this single file (-s).
  inputBinding:
    position: 103
    prefix: -s
- id: single_ended_fastq
  type:
  - 'null'
  - File
  doc: Read single-ended data from this file (-0).
  inputBinding:
    position: 103
    prefix: '-0'
- id: read1_fastq
  type:
  - 'null'
  - File
  doc: Read-1 from this file.
  inputBinding:
    position: 103
    prefix: '-1'
- id: read2_fastq
  type:
  - 'null'
  - File
  doc: Read-2 from this file.
  inputBinding:
    position: 103
    prefix: '-2'
- id: index1_fastq
  type:
  - 'null'
  - File
  doc: Index-1 from this file.
  inputBinding:
    position: 103
    prefix: --i1
- id: index2_fastq
  type:
  - 'null'
  - File
  doc: Index-2 from this file.
  inputBinding:
    position: 103
    prefix: --i2
- id: casava
  type:
  - 'null'
  - boolean
  doc: Parse CASAVA identifier.
  inputBinding:
    position: 103
    prefix: -i
- id: umi
  type:
  - 'null'
  - boolean
  doc: Parse UMI from read name.
  inputBinding:
    position: 103
    prefix: --UMI
- id: umi_tag
  type:
  - 'null'
  - string
  doc: Tag to use for UMI sequences [RX].
  inputBinding:
    position: 103
    prefix: --UMI-tag
- id: barcode_tag
  type:
  - 'null'
  - string
  doc: Tag to use with barcode sequences [BC].
  inputBinding:
    position: 103
    prefix: --barcode-tag
- id: quality_tag
  type:
  - 'null'
  - string
  doc: Tag to use with barcode qualities [QT].
  inputBinding:
    position: 103
    prefix: --quality-tag
- id: name2
  type:
  - 'null'
  - boolean
  doc: Use 2nd field as read name (SRA format).
  inputBinding:
    position: 103
    prefix: --name2
- id: rg_line
  type:
  - 'null'
  - string
  doc: Build up a complete @RG line (-r).
  inputBinding:
    position: 103
    prefix: -r
- id: rg_id
  type:
  - 'null'
  - string
  doc: Add a simple RG line of @RG ID:STRING (-R).
  inputBinding:
    position: 103
    prefix: -R
- id: tag_list
  type:
  - 'null'
  - string
  doc: Parse tags in SAM format; list of tags or '*' for all (-T).
  inputBinding:
    position: 103
    prefix: -T
- id: output_filename
  type: string
  doc: Output file (-o).
  default: imported.bam
  inputBinding:
    position: 103
    prefix: -o
- id: uncompressed
  type:
  - 'null'
  - boolean
  doc: Uncompressed output.
  inputBinding:
    position: 103
    prefix: -u
- id: order
  type:
  - 'null'
  - string
  doc: Store Nth record count in TAG.
  inputBinding:
    position: 103
    prefix: --order
- id: no_pg
  type:
  - 'null'
  - boolean
  doc: Do not add a PG line.
  inputBinding:
    position: 103
    prefix: --no-PG
- id: threads
  type:
  - 'null'
  - int
  doc: Number of additional threads to use [0].
  inputBinding:
    position: 103
    prefix: --threads
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
- id: output_fmt_option
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --output-fmt-option
  doc: Specify a single output file format option in the form OPTION or OPTION=VALUE (repeatable).
  inputBinding:
    position: 103
- id: output_fmt
  type:
  - 'null'
  - string
  doc: Output format FORMAT[,OPT[=VAL]]... (SAM, BAM, CRAM).
  inputBinding:
    position: 103
    prefix: --output-fmt
outputs:
- id: output
  type: File
  doc: Unaligned alignment file made from the reads.
  outputBinding:
    glob: $(inputs.output_filename)
