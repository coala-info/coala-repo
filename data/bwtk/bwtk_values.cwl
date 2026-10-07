cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwtk
  - values
label: bwtk_values
doc: "Return bigWig values from overlapping BED ranges\n\nTool homepage: https://github.com/bjmt/bwtk"
inputs:
  - id: input_bigwig
    type: File
    doc: Input bigWig
    inputBinding:
      position: 1
      prefix: -i
  - id: bed_file
    type: File
    doc: BED file with ranges to extract values from
    inputBinding:
      position: 1
      prefix: -b
  - id: output_tsv
    type: string
    doc: Output values in TSV format
    inputBinding:
      position: 1
      prefix: -o
  - id: range_size
    type:
      - 'null'
      - int
    doc: Desired size of ranges, will be resized from the centre
    inputBinding:
      position: 1
      prefix: -s
  - id: resize_left
    type:
      - 'null'
      - boolean
    doc: Resize ranges from the left with -s (based on strand)
    inputBinding:
      position: 1
      prefix: -l
  - id: resize_right
    type:
      - 'null'
      - boolean
    doc: Resize ranges from the right with -s (based on strand)
    inputBinding:
      position: 1
      prefix: -r
outputs:
  - id: values
    type: File
    doc: bigWig values per BED range in TSV format
    outputBinding:
      glob: $(inputs.output_tsv)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwtk:1.8.1--h9990f68_0
