cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - merge
label: samtools_merge
doc: Merge multiple sorted alignment files, producing a single sorted output 
  file
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input BAM/SAM/CRAM files to merge
    inputBinding:
      position: 1
  - id: output_file
    type:
      - 'null'
      - string
    doc: Specify output file via option instead of <out.bam> argument
    inputBinding:
      position: 102
      prefix: -o
  - id: sort_by_read_name_natural
    type:
      - 'null'
      - boolean
    doc: Input files are sorted by read name (natural)
    inputBinding:
      position: 102
      prefix: -n
  - id: sort_by_read_name_ascii
    type:
      - 'null'
      - boolean
    doc: Input files are sorted by read name (ASCII)
    inputBinding:
      position: 102
      prefix: -N
  - id: sort_by_tag
    type:
      - 'null'
      - string
    doc: Input files are sorted by TAG value
    inputBinding:
      position: 102
      prefix: -t
  - id: attach_rg_tag
    type:
      - 'null'
      - boolean
    doc: Attach RG tag (inferred from file names)
    inputBinding:
      position: 102
      prefix: -r
  - id: uncompressed_bam_output
    type:
      - 'null'
      - boolean
    doc: Uncompressed BAM output
    inputBinding:
      position: 102
      prefix: -u
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite the output BAM if exist
    inputBinding:
      position: 102
      prefix: -f
  - id: compress_level_1
    type:
      - 'null'
      - boolean
    doc: Compress level 1
    inputBinding:
      position: 102
      prefix: '-1'
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Compression level, from 0 to 9
    inputBinding:
      position: 102
      prefix: -l
  - id: region
    type:
      - 'null'
      - string
    doc: Merge file in the specified region STR
    inputBinding:
      position: 102
      prefix: -R
  - id: header_file
    type:
      - 'null'
      - File
    doc: Copy the header in FILE to <out.bam> [in1.bam]
    inputBinding:
      position: 102
      prefix: -h
  - id: combine_rg_headers
    type:
      - 'null'
      - boolean
    doc: Combine @RG headers with colliding IDs [alter IDs to be distinct]
    inputBinding:
      position: 102
      prefix: -c
  - id: combine_pg_headers
    type:
      - 'null'
      - boolean
    doc: Combine @PG headers with colliding IDs [alter IDs to be distinct]
    inputBinding:
      position: 102
      prefix: -p
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Override random seed
    inputBinding:
      position: 102
      prefix: -s
  - id: bam_list_file
    type:
      - 'null'
      - File
    doc: List of input BAM filenames, one per line
    inputBinding:
      position: 102
      prefix: -b
  - id: custom_index_files
    type:
      - 'null'
      - boolean
    doc: Use customized index files
    inputBinding:
      position: 102
      prefix: -X
  - id: bed_file
    type:
      - 'null'
      - File
    doc: Specify a BED file for multiple region filtering
    inputBinding:
      position: 102
      prefix: -L
  - id: no_pg
    type:
      - 'null'
      - boolean
    doc: do not add a PG line
    inputBinding:
      position: 102
      prefix: --no-PG
  - id: template_coordinate
    type:
      - 'null'
      - boolean
    doc: Input files are sorted by template-coordinate
    inputBinding:
      position: 102
      prefix: --template-coordinate
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
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference sequence FASTA FILE
    secondaryFiles:
      - .fai
    inputBinding:
      position: 102
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of additional threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: write_index
    type:
      - 'null'
      - boolean
    doc: Automatically index the output files
    inputBinding:
      position: 102
      prefix: --write-index
outputs:
  - id: output_output_file
    type:
      - 'null'
      - File
    doc: Specify output file via option instead of <out.bam> argument
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
