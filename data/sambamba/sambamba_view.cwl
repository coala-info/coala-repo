cwlVersion: v1.2
class: CommandLineTool
baseCommand: sambamba-view
label: sambamba_view
doc: "View and convert SAM/BAM/CRAM files\n\nTool homepage: https://github.com/biod/sambamba"
inputs:
  - id: input_file
    type: File
    doc: Input BAM/SAM file
    inputBinding:
      position: 1
  - id: regions
    type:
      - 'null'
      - type: array
        items: string
    doc: Region(s) to extract
    inputBinding:
      position: 2
  - id: compression_level
    type:
      - 'null'
      - int
    doc: specify compression level (from 0 to 9, works only for BAM output)
    inputBinding:
      position: 103
      prefix: --compression-level
  - id: count
    type:
      - 'null'
      - boolean
    doc: output to stdout only count of matching records, hHI are ignored
    inputBinding:
      position: 103
      prefix: --count
  - id: filter
    type:
      - 'null'
      - string
    doc: set custom filter for alignments
    inputBinding:
      position: 103
      prefix: --filter
  - id: format
    type:
      - 'null'
      - string
    doc: specify which format to use for output (default is SAM); unpack streams
      unpacked BAM
    inputBinding:
      position: 103
      prefix: --format
  - id: header
    type:
      - 'null'
      - boolean
    doc: output only header to stdout (if format=bam, the header is printed as 
      SAM)
    inputBinding:
      position: 103
      prefix: --header
  - id: nthreads
    type:
      - 'null'
      - int
    doc: maximum number of threads to use
    inputBinding:
      position: 103
      prefix: --nthreads
  - id: num_filter
    type:
      - 'null'
      - string
    doc: filter flag bits; 'i1/i2' corresponds to -f i1 -F i2 samtools 
      arguments; either of the numbers can be omitted
    inputBinding:
      position: 103
      prefix: --num-filter
  - id: ref_filename
    type:
      - 'null'
      - File
    doc: specify reference for writing (NA)
    inputBinding:
      position: 103
      prefix: --ref-filename
  - id: reference_info
    type:
      - 'null'
      - boolean
    doc: output to stdout only reference names and lengths in JSON
    inputBinding:
      position: 103
      prefix: --reference-info
  - id: regions_file
    type:
      - 'null'
      - File
    doc: output only reads overlapping one of regions from the BED file
    inputBinding:
      position: 103
      prefix: --regions
  - id: sam_input
    type:
      - 'null'
      - boolean
    doc: specify that input is in SAM format
    inputBinding:
      position: 103
      prefix: --sam-input
  - id: show_progress
    type:
      - 'null'
      - boolean
    doc: show progressbar in STDERR (works only for BAM files with no regions 
      specified)
    inputBinding:
      position: 103
      prefix: --show-progress
  - id: subsample
    type:
      - 'null'
      - float
    doc: subsample reads (read pairs)
    inputBinding:
      position: 103
      prefix: --subsample
  - id: subsampling_seed
    type:
      - 'null'
      - int
    doc: set seed for subsampling
    inputBinding:
      position: 103
      prefix: --subsampling-seed
  - id: valid
    type:
      - 'null'
      - boolean
    doc: output only valid alignments
    inputBinding:
      position: 103
      prefix: --valid
  - id: with_header
    type:
      - 'null'
      - boolean
    doc: print header before reads (always done for BAM output)
    inputBinding:
      position: 103
      prefix: --with-header
outputs:
  - id: output_filename
    type:
      - 'null'
      - File
    doc: specify output filename
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sambamba:1.0.1--he614052_4
