cwlVersion: v1.2
class: CommandLineTool
label: samtools_depad
doc: |-
  Convert a padded BAM/SAM file to an unpadded BAM/SAM file

  Tool homepage: https://github.com/samtools/samtools
requirements:
- class: InitialWorkDirRequirement
  listing:
  - entryname: $(inputs.reference.basename)
    entry: $(inputs.reference)
  - entryname: $(inputs.input_file.basename)
    entry: $(inputs.input_file)
- class: InlineJavascriptRequirement
baseCommand:
- samtools
- depad
inputs:
- id: input_file
  type: File
  doc: Input BAM/SAM file
  inputBinding:
    position: 10
    valueFrom: $(self.basename)
- id: fast_compression
  type: boolean?
  doc: Fast compression BAM output (can't use with -s)
  inputBinding:
    position: 1
    prefix: '-1'
- id: input_fmt_option
  type: string[]?
  doc: Specify a single input file format option in the form of OPTION or 
    OPTION=VALUE
  inputBinding:
    position: 1
    prefix: --input-fmt-option
- id: input_sam
  type: boolean?
  doc: Input is SAM (default is BAM)
  inputBinding:
    position: 1
    prefix: -S
- id: no_pg
  type: boolean?
  doc: do not add a PG line
  inputBinding:
    position: 1
    prefix: --no-PG
- id: output_fmt
  type: string?
  doc: Specify output format (SAM, BAM, CRAM)
  inputBinding:
    position: 1
    prefix: --output-fmt
- id: output_fmt_option
  type: string[]?
  doc: Specify a single output file format option in the form of OPTION or 
    OPTION=VALUE
  inputBinding:
    position: 1
    prefix: --output-fmt-option
- id: output_sam
  type: boolean?
  doc: Output is SAM (default is BAM)
  inputBinding:
    position: 1
    prefix: -s
- id: reference
  type: File
  doc: Padded reference sequence file
  inputBinding:
    position: 1
    prefix: --reference
    valueFrom: $(self.basename)
- id: uncompressed_bam
  type: boolean?
  doc: Uncompressed BAM output (can't use with -s)
  inputBinding:
    position: 1
    prefix: -u
- id: verbosity
  type: int?
  doc: Set level of verbosity
  inputBinding:
    position: 1
    prefix: --verbosity
- id: write_index
  type: boolean?
  doc: Automatically index the output files
  inputBinding:
    position: 1
    prefix: --write-index
stdout: output.bam
outputs:
- id: output_file
  type: File
  doc: Output file name
  outputBinding:
    glob: output.bam
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
