cwlVersion: v1.2
class: CommandLineTool
baseCommand: fba_count
label: fba_count
doc: "Count UMIs per feature per cell (UMI deduplication), powered by UMI-tools (Smith,
  T., et al. 2017). Take the output of `extract` or `filter` as input.\n\nTool homepage:
  https://github.com/jlduan/fba"
inputs:
  - id: cell_barcode_reverse_complement
    type:
      - 'null'
      - boolean
    doc: specify to convert cell barcode sequences into their reverse-complement
      counterparts in the output.
    inputBinding:
      position: 101
      prefix: --cell_barcode_reverse_complement
  - id: input_files
    type:
      type: array
      items: File
    doc: specify input files. Multiple '-i' flags can be used.
    inputBinding:
      position: 101
      prefix: --input
  - id: umi_deduplication_method
    type:
      - 'null'
      - string
    doc: specify UMI deduplication method (powered by UMI-tools. Smith, T., et 
      al. 2017).
    default: directional
    inputBinding:
      position: 101
      prefix: --umi_deduplication_method
  - id: umi_length
    type:
      - 'null'
      - int
    doc: specify the length of UMIs on read 1. Reads with UMI length shorter 
      than this value will be discarded. Coordinate is 0-based, half-open. For 
      example, '-us 16 -ul 12' means UMI starts at 16 ends at 27.
    default: 12
    inputBinding:
      position: 101
      prefix: --umi_length
  - id: umi_mismatches
    type:
      - 'null'
      - int
    doc: specify the maximun edit distance allowed for UMIs on read 1 for 
      deduplication.
    default: 1
    inputBinding:
      position: 101
      prefix: --umi_mismatches
  - id: umi_start
    type:
      - 'null'
      - int
    doc: specify expected UMI starting postion on read 1. Coordinate is 0-based,
      half-open.
    default: 16
    inputBinding:
      position: 101
      prefix: --umi_start
outputs:
  - id: output_file
    type: File
    doc: specify an output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fba:0.0.13--pyhdfd78af_0
