cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- merge
label: samtools_merge
doc: "Merge multiple sorted alignment files into one.\n\nTool homepage: https://github.com/samtools/samtools"
requirements:
- class: InlineJavascriptRequirement
inputs:
- id: output_filename
  type: string
  default: merged.bam
  doc: Name of the output BAM file
  inputBinding:
    position: 1
- id: input_bams
  type:
    type: array
    items: File
  doc: Input BAM files to be merged
  inputBinding:
    position: 2
- id: attach_rg_tag
  type:
  - 'null'
  - boolean
  doc: Attach RG tag (inferred from file names)
  inputBinding:
    position: 102
    prefix: -r
- id: bed_file
  type:
  - 'null'
  - File
  doc: Specify a BED file for multiple region filtering
  inputBinding:
    position: 102
    prefix: -L
- id: combine_pg_headers
  type:
  - 'null'
  - boolean
  doc: Combine @PG headers with colliding IDs [alter IDs to be distinct]
  inputBinding:
    position: 102
    prefix: -p
- id: combine_rg_headers
  type:
  - 'null'
  - boolean
  doc: Combine @RG headers with colliding IDs [alter IDs to be distinct]
  inputBinding:
    position: 102
    prefix: -c
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
- id: customized_index
  type:
  - 'null'
  - boolean
  doc: Use customized index files
  inputBinding:
    position: 102
    prefix: -X
- id: header_file
  type:
  - 'null'
  - File
  doc: Copy the header in FILE to <out.bam>
  inputBinding:
    position: 102
    prefix: -h
- id: input_bam_list
  type:
  - 'null'
  - File
  doc: List of input BAM filenames, one per line
  inputBinding:
    position: 102
    prefix: -b
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
- id: no_pg
  type:
  - 'null'
  - boolean
  doc: do not add a PG line
  inputBinding:
    position: 102
    prefix: --no-PG
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
  - type: array
    items: string
  doc: Specify a single output file format option in the form of OPTION or 
    OPTION=VALUE
  inputBinding:
    position: 102
    prefix: --output-fmt-option
- id: overwrite_output
  type:
  - 'null'
  - boolean
  doc: Overwrite the output BAM if exist
  inputBinding:
    position: 102
    prefix: -f
- id: random_seed
  type:
  - 'null'
  - int
  doc: Override random seed
  inputBinding:
    position: 102
    prefix: -s
- id: reference
  type:
  - 'null'
  - File
  doc: Reference sequence FASTA FILE
  inputBinding:
    position: 102
    prefix: --reference
- id: region
  type:
  - 'null'
  - string
  doc: Merge file in the specified region STR
  inputBinding:
    position: 102
    prefix: -R
- id: sort_by_read_name_ascii
  type:
  - 'null'
  - boolean
  doc: Input files are sorted by read name (ASCII)
  inputBinding:
    position: 102
    prefix: -N
- id: sort_by_read_name_natural
  type:
  - 'null'
  - boolean
  doc: Input files are sorted by read name (natural)
  inputBinding:
    position: 102
    prefix: -n
- id: sort_by_tag
  type:
  - 'null'
  - string
  doc: Input files are sorted by TAG value
  inputBinding:
    position: 102
    prefix: -t
- id: template_coordinate
  type:
  - 'null'
  - boolean
  doc: Input files are sorted by template-coordinate
  inputBinding:
    position: 102
    prefix: --template-coordinate
- id: threads
  type:
  - 'null'
  - int
  doc: Number of additional threads to use
  default: 0
  inputBinding:
    position: 102
    prefix: --threads
- id: uncompressed_bam
  type:
  - 'null'
  - boolean
  doc: Uncompressed BAM output
  inputBinding:
    position: 102
    prefix: -u
- id: verbosity
  type:
  - 'null'
  - int
  doc: Set level of verbosity
  inputBinding:
    position: 102
    prefix: --verbosity
- id: write_index
  type:
  - 'null'
  - boolean
  doc: Automatically index the output files
  inputBinding:
    position: 102
    prefix: --write-index
outputs:
- id: output_bam
  type: File
  doc: Output BAM file
  outputBinding:
    glob: $(inputs.output_filename)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
