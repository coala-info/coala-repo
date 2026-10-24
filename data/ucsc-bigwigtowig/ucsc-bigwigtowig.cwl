cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigWigToWig
label: ucsc-bigwigtowig
doc: "Convert bigWig to wig. This will keep more of the same structure of the original wig than bigWigToBedGraph does, but still will break up large stepped sections into smaller ones.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_bigwig
    type: File
    doc: "Input bigWig file"
    inputBinding:
      position: 1
  - id: output_file
    type: string
    doc: "Name of the output wig file"
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
    doc: "Output wig file"
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bigwigtowig:482--h0b57e2e_0
