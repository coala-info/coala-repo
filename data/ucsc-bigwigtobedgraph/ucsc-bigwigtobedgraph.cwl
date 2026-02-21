cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigWigToBedGraph
label: ucsc-bigwigtobedgraph
doc: "Convert bigWig to bedGraph format.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_big_wig
    type: File
    doc: The input bigWig file.
    inputBinding:
      position: 1
  - id: chrom
    type:
      - 'null'
      - string
    doc: Restrict output to a specific chromosome.
    inputBinding:
      position: 102
      prefix: -chrom
  - id: end
    type:
      - 'null'
      - int
    doc: Restrict output to portion of chromosome ending at end.
    inputBinding:
      position: 102
      prefix: -end
  - id: start
    type:
      - 'null'
      - int
    doc: Restrict output to portion of chromosome starting at start.
    inputBinding:
      position: 102
      prefix: -start
  - id: udc_dir
    type:
      - 'null'
      - Directory
    doc: Specifies the directory where the UDC cache is located.
    inputBinding:
      position: 102
      prefix: -udcDir
outputs:
  - id: output_bed_graph
    type: File
    doc: The output bedGraph file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bigwigtobedgraph:482--h0b57e2e_0
