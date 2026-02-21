cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigWigToWig
label: ucsc-bigwigtowig
doc: "Convert bigWig to wig format.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_file
    type: File
    doc: The input bigWig file (.bw)
    inputBinding:
      position: 1
  - id: chrom
    type:
      - 'null'
      - string
    doc: If set, restrict output to given chromosome (e.g., -chrom=chr1)
    inputBinding:
      position: 102
      prefix: -chrom
  - id: end
    type:
      - 'null'
      - int
    doc: If set, restrict output to only that under end
    inputBinding:
      position: 102
      prefix: -end
  - id: start
    type:
      - 'null'
      - int
    doc: If set, restrict output to only that over start
    inputBinding:
      position: 102
      prefix: -start
  - id: udc_dir
    type:
      - 'null'
      - Directory
    doc: Place to keep the line file cache
    inputBinding:
      position: 102
      prefix: -udcDir
outputs:
  - id: output_file
    type: File
    doc: The output wig file (.wig)
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bigwigtowig:482--h0b57e2e_0
