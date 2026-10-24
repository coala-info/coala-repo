cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigWigToBedGraph
label: ucsc-bigwigtobedgraph
doc: "Convert from bigWig to bedGraph format.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_bigwig
    type: File
    doc: "Input bigWig file"
    inputBinding:
      position: 1
  - id: output_file
    type: string
    doc: "Name of the output bedGraph file"
    inputBinding:
      position: 2
  - id: chrom
    type:
      - 'null'
      - string
    doc: "If set restrict output to given chromosome"
    inputBinding:
      position: 101
      prefix: -chrom=
      separate: false
  - id: start
    type:
      - 'null'
      - int
    doc: "If set, restrict output to only that over start"
    inputBinding:
      position: 101
      prefix: -start=
      separate: false
  - id: end
    type:
      - 'null'
      - int
    doc: "If set, restrict output to only that under end"
    inputBinding:
      position: 101
      prefix: -end=
      separate: false
  - id: udc_dir
    type:
      - 'null'
      - string
    doc: "Place to put cache for remote bigBed/bigWigs"
    inputBinding:
      position: 101
      prefix: -udcDir=
      separate: false
outputs:
  - id: out_output_file
    type: File
    doc: "Output bedGraph file"
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bigwigtobedgraph:482--h0b57e2e_0
