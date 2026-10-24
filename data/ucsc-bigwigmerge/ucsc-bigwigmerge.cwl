cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigWigMerge
label: ucsc-bigwigmerge
doc: "Merge together multiple bigWigs into a single output bedGraph.\nYou'll have to run bedGraphToBigWig to make the output bigWig.\nThe signal values are just added together to merge them.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: "Input bigWig files (or files listing bigWig names when in_list is set)"
    inputBinding:
      position: 1
  - id: output_bedgraph
    type: string
    doc: "Name of the output bedGraph file"
    inputBinding:
      position: 2
  - id: threshold
    type:
      - 'null'
      - float
    doc: "Don't output values at or below this threshold. Default is 0.0"
    inputBinding:
      position: 101
      prefix: -threshold=
      separate: false
  - id: adjust
    type:
      - 'null'
      - float
    doc: "Add adjustment to each value"
    inputBinding:
      position: 101
      prefix: -adjust=
      separate: false
  - id: clip
    type:
      - 'null'
      - float
    doc: "Values higher than this are clipped to this value"
    inputBinding:
      position: 101
      prefix: -clip=
      separate: false
  - id: in_list
    type:
      - 'null'
      - boolean
    doc: "Input files are lists of file names of bigWigs"
    inputBinding:
      position: 101
      prefix: -inList
  - id: max
    type:
      - 'null'
      - boolean
    doc: "Merged value is maximum from input files rather than sum"
    inputBinding:
      position: 101
      prefix: -max
outputs:
  - id: out_output_bedgraph
    type: File
    doc: "Merged bedGraph file"
    outputBinding:
      glob: $(inputs.output_bedgraph)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bigwigmerge:482--h0b57e2e_0
