cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - import
label: samtools_import
doc: Converts FASTQ files to SAM, BAM, or CRAM format
inputs:
  - id: fastq_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input FASTQ file(s)
    inputBinding:
      position: 1
  - id: interleaved_fastq
    type:
      - 'null'
      - File
    doc: Read paired-ended data from single FILE
    inputBinding:
      position: 102
      prefix: -s
  - id: single_ended_fastq
    type:
      - 'null'
      - File
    doc: Read single-ended data from FILE
    inputBinding:
      position: 102
      prefix: '-0'
  - id: read1_fastq
    type:
      - 'null'
      - File
    doc: Read-1 from FILE
    inputBinding:
      position: 102
      prefix: '-1'
  - id: read2_fastq
    type:
      - 'null'
      - File
    doc: Read-2 from FILE
    inputBinding:
      position: 102
      prefix: '-2'
  - id: index1_fastq
    type:
      - 'null'
      - File
    doc: Index-1 from FILE
    inputBinding:
      position: 102
      prefix: --i1
  - id: index2_fastq
    type:
      - 'null'
      - File
    doc: Index-2 from FILE
    inputBinding:
      position: 102
      prefix: --i2
  - id: casava
    type:
      - 'null'
      - boolean
    doc: Parse CASAVA identifier
    inputBinding:
      position: 102
      prefix: -i
  - id: umi
    type:
      - 'null'
      - boolean
    doc: Parse UMI from read name
    inputBinding:
      position: 102
      prefix: --UMI
  - id: umi_tag
    type:
      - 'null'
      - string
    doc: Tag to use for UMI sequences
    inputBinding:
      position: 102
      prefix: --UMI-tag
  - id: barcode_tag
    type:
      - 'null'
      - string
    doc: Tag to use with barcode sequences
    inputBinding:
      position: 102
      prefix: --barcode-tag
  - id: quality_tag
    type:
      - 'null'
      - string
    doc: Tag to use with barcode qualities
    inputBinding:
      position: 102
      prefix: --quality-tag
  - id: name2
    type:
      - 'null'
      - boolean
    doc: Use 2nd field as read name (SRA format)
    inputBinding:
      position: 102
      prefix: --name2
  - id: rg_line
    type:
      - 'null'
      - string
    doc: Build up a complete @RG line
    inputBinding:
      position: 102
      prefix: -r
  - id: rg_id
    type:
      - 'null'
      - string
    doc: Add a simple RG line of "@RG\tID:STRING"
    inputBinding:
      position: 102
      prefix: -R
  - id: tag_list
    type:
      - 'null'
      - string
    doc: Parse tags in SAM format; list of '*' for all
    inputBinding:
      position: 102
      prefix: -T
  - id: output_file
    type:
      - 'null'
      - string
    doc: Output to FILE instead of stdout
    inputBinding:
      position: 102
      prefix: -o
  - id: uncompressed
    type:
      - 'null'
      - boolean
    doc: Uncompressed output
    inputBinding:
      position: 102
      prefix: -u
  - id: order
    type:
      - 'null'
      - string
    doc: Store Nth record count in TAG
    inputBinding:
      position: 102
      prefix: --order
  - id: no_pg
    type:
      - 'null'
      - boolean
    doc: Do not add a PG line
    inputBinding:
      position: 102
      prefix: --no-PG
  - id: input_fmt_option
    type:
      - 'null'
      - string
    doc: Specify a single input file format option in the form of OPTION or 
      OPTION=VALUE
    inputBinding:
      position: 102
      prefix: --input-fmt-option
  - id: output_fmt
    type:
      - 'null'
      - string
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
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of additional threads to use
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_output_file
    type:
      - 'null'
      - File
    doc: Output to FILE instead of stdout
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
s:url: https://github.com/samtools/samtools
$namespaces:
  s: https://schema.org/
