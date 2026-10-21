cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- split
label: samtools_split
doc: 'Split a file by read group or tag value


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: input_file
  type: File
  doc: Merged input BAM/CRAM file.
  inputBinding:
    position: 104
- id: format_string
  type:
  - 'null'
  - string
  doc: Output filename format string [%*_%#.%.]; %* basename, %# index, %! RG ID or tag value, %. extension.
  inputBinding:
    position: 103
    prefix: -f
- id: unaccounted_bam_name
  type:
  - 'null'
  - string
  doc: Put left-over reads in this file (-u).
  inputBinding:
    position: 103
    prefix: -u
- id: unaccounted_header
  type:
  - 'null'
  - File
  doc: Override the header of the -u file with this SAM header (-h).
  inputBinding:
    position: 103
    prefix: -h
- id: split_tag
  type:
  - 'null'
  - string
  doc: Split by TAG value; the value must be a string (-d).
  inputBinding:
    position: 103
    prefix: -d
- id: pad_numbers
  type:
  - 'null'
  - int
  doc: Zero-pad numbers in filenames to NUMBER digits.
  inputBinding:
    position: 103
    prefix: -p
- id: max_split
  type:
  - 'null'
  - int
  doc: Limit number of output files from -d to NUM [100].
  inputBinding:
    position: 103
    prefix: --max-split
- id: verbose
  type:
  - 'null'
  - boolean
  doc: Verbose output.
  inputBinding:
    position: 103
    prefix: -v
- id: reference
  type:
  - 'null'
  - File
  doc: Reference sequence FASTA file (needed for CRAM).
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
  doc: Number of additional threads to use.
  inputBinding:
    position: 103
    prefix: --threads
- id: write_index
  type:
  - 'null'
  - boolean
  doc: Automatically index the output file.
  inputBinding:
    position: 103
    prefix: --write-index
- id: no_pg
  type:
  - 'null'
  - boolean
  doc: Do not add a PG line to the header.
  inputBinding:
    position: 103
    prefix: --no-PG
- id: verbosity
  type:
  - 'null'
  - int
  doc: Set level of verbosity.
  inputBinding:
    position: 103
    prefix: --verbosity
- id: output_fmt
  type:
  - 'null'
  - string
  doc: Output format FORMAT[,OPT[=VAL]]... (SAM, BAM, CRAM).
  inputBinding:
    position: 103
    prefix: --output-fmt
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
outputs:
- id: split_files
  type:
    type: array
    items: File
  doc: Alignment files, one per read group or tag value.
  outputBinding:
    glob:
    - '*.bam'
    - '*.cram'
    - '*.sam'
- id: split_indexes
  type:
  - 'null'
  - type: array
    items: File
  doc: Indexes written with --write-index.
  outputBinding:
    glob:
    - '*.bai'
    - '*.csi'
    - '*.crai'
