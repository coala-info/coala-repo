cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- import
label: samtools_import
doc: "Import FASTQ files into SAM/BAM/CRAM format\n\nTool homepage: https://github.com/samtools/samtools"
requirements:
- class: InlineJavascriptRequirement
inputs:
- id: fastq_files
  type:
  - 'null'
  - type: array
    items: File
  doc: Input FASTQ files
  inputBinding:
    position: 1
- id: barcode_tag
  type:
  - 'null'
  - string
  doc: Tag to use with barcode sequences
  inputBinding:
    position: 102
    prefix: --barcode-tag
- id: index1_file
  type:
  - 'null'
  - File
  doc: Index-1 from FILE
  inputBinding:
    position: 102
    prefix: --i1
- id: index2_file
  type:
  - 'null'
  - File
  doc: Index-2 from FILE
  inputBinding:
    position: 102
    prefix: --i2
- id: input_fmt_option
  type:
  - 'null'
  - string
  doc: Specify a single input file format option in the form of OPTION or 
    OPTION=VALUE
  inputBinding:
    position: 102
    prefix: --input-fmt-option
- id: no_pg
  type:
  - 'null'
  - boolean
  doc: Do not add a PG line
  inputBinding:
    position: 102
    prefix: --no-PG
- id: order_tag
  type:
  - 'null'
  - string
  doc: Store Nth record count in TAG
  inputBinding:
    position: 102
    prefix: --order
- id: output_fmt
  type:
  - 'null'
  - type: array
    items: string
  doc: Specify output format (SAM, BAM, CRAM)
  inputBinding:
    position: 102
    prefix: --output-fmt
- id: output_fmt_option
  type:
  - 'null'
  - string
  doc: Specify a single output file format option in the form of OPTION or 
    OPTION=VALUE
  inputBinding:
    position: 102
    prefix: --output-fmt-option
- id: parse_casava
  type:
  - 'null'
  - boolean
  doc: Parse CASAVA identifier
  inputBinding:
    position: 102
    prefix: -i
- id: parse_tags
  type:
  - 'null'
  - string
  doc: Parse tags in SAM format; list of '*' for all
  inputBinding:
    position: 102
    prefix: -T
- id: parse_umi
  type:
  - 'null'
  - boolean
  doc: Parse UMI from read name
  inputBinding:
    position: 102
    prefix: --UMI
- id: quality_tag
  type:
  - 'null'
  - string
  doc: Tag to use with barcode qualities
  inputBinding:
    position: 102
    prefix: --quality-tag
- id: read1_file
  type:
  - 'null'
  - File
  doc: Read-1 from FILE
  inputBinding:
    position: 102
    prefix: '-1'
- id: read2_file
  type:
  - 'null'
  - File
  doc: Read-2 from FILE
  inputBinding:
    position: 102
    prefix: '-2'
- id: rg_line_complete
  type:
  - 'null'
  - string
  doc: Build up a complete @RG line
  inputBinding:
    position: 102
    prefix: -r
- id: rg_line_simple
  type:
  - 'null'
  - string
  doc: Add a simple RG line of "@RG\tID:STRING"
  inputBinding:
    position: 102
    prefix: -R
- id: single_ended_file
  type:
  - 'null'
  - File
  doc: Read single-ended data from FILE
  inputBinding:
    position: 102
    prefix: '-0'
- id: single_file
  type:
  - 'null'
  - File
  doc: Read paired-ended data from single FILE
  inputBinding:
    position: 102
    prefix: -s
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
  doc: Tag to use for UMI sequences
  inputBinding:
    position: 102
    prefix: --UMI-tag
- id: uncompressed_output
  type:
  - 'null'
  - boolean
  doc: Uncompressed output
  inputBinding:
    position: 102
    prefix: -u
- id: use_name2
  type:
  - 'null'
  - boolean
  doc: Use 2nd field as read name (SRA format)
  inputBinding:
    position: 102
    prefix: --name2
stdout: output.sam
outputs:
- id: output_file
  type: stdout
  doc: Output to FILE instead of stdout
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
