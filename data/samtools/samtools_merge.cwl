cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- merge
label: samtools_merge
doc: 'Merge multiple sorted alignment files, producing a single sorted output file


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: input_files
  type:
  - 'null'
  - type: array
    items: File
  doc: Input sorted alignment files (indexes are needed for region options).
  secondaryFiles:
  - pattern: .bai
    required: false
  - pattern: .csi
    required: false
  - pattern: .crai
    required: false
  - pattern: ^.bai
    required: false
  inputBinding:
    position: 104
- id: output_filename
  type: string
  doc: Output file (-o).
  default: merged.bam
  inputBinding:
    position: 103
    prefix: -o
- id: sort_by_name_natural
  type:
  - 'null'
  - boolean
  doc: Input files are sorted by read name (natural).
  inputBinding:
    position: 103
    prefix: -n
- id: sort_by_name_ascii
  type:
  - 'null'
  - boolean
  doc: Input files are sorted by read name (ASCII).
  inputBinding:
    position: 103
    prefix: -N
- id: sort_by_tag
  type:
  - 'null'
  - string
  doc: Input files are sorted by TAG value.
  inputBinding:
    position: 103
    prefix: -t
- id: attach_rg_tag
  type:
  - 'null'
  - boolean
  doc: Attach RG tag (inferred from file names).
  inputBinding:
    position: 103
    prefix: -r
- id: uncompressed
  type:
  - 'null'
  - boolean
  doc: Uncompressed BAM output.
  inputBinding:
    position: 103
    prefix: -u
- id: force_overwrite
  type:
  - 'null'
  - boolean
  doc: Overwrite the output BAM if it exists.
  inputBinding:
    position: 103
    prefix: -f
- id: compress_level_1
  type:
  - 'null'
  - boolean
  doc: Compress level 1.
  inputBinding:
    position: 103
    prefix: '-1'
- id: compression_level
  type:
  - 'null'
  - int
  doc: Compression level, from 0 to 9 [-1].
  inputBinding:
    position: 103
    prefix: -l
- id: region
  type:
  - 'null'
  - string
  doc: Merge file in the specified region STR [all].
  inputBinding:
    position: 103
    prefix: -R
- id: header_file
  type:
  - 'null'
  - File
  doc: Copy the header in this file to the output [first input].
  inputBinding:
    position: 103
    prefix: -h
- id: combine_rg_headers
  type:
  - 'null'
  - boolean
  doc: Combine @RG headers with colliding IDs [alter IDs to be distinct].
  inputBinding:
    position: 103
    prefix: -c
- id: combine_pg_headers
  type:
  - 'null'
  - boolean
  doc: Combine @PG headers with colliding IDs [alter IDs to be distinct].
  inputBinding:
    position: 103
    prefix: -p
- id: random_seed
  type:
  - 'null'
  - string
  doc: Override random seed.
  inputBinding:
    position: 103
    prefix: -s
- id: bam_list_file
  type:
  - 'null'
  - File
  doc: List of input BAM file names, one per line.
  inputBinding:
    position: 103
    prefix: -b
- id: custom_index_files
  type:
  - 'null'
  - boolean
  doc: Use customized index files.
  inputBinding:
    position: 103
    prefix: -X
- id: bed_file
  type:
  - 'null'
  - File
  doc: BED file for multiple region filtering.
  inputBinding:
    position: 103
    prefix: -L
- id: template_coordinate
  type:
  - 'null'
  - boolean
  doc: Input files are sorted by template-coordinate.
  inputBinding:
    position: 103
    prefix: --template-coordinate
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
  doc: Merged alignment file.
  outputBinding:
    glob: $(inputs.output_filename)
- id: output_index
  type:
  - 'null'
  - File
  doc: Index of the output file when --write-index is used.
  outputBinding:
    glob:
    - $(inputs.output_filename).bai
    - $(inputs.output_filename).csi
    - $(inputs.output_filename).crai
