cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigWigSummary
label: ucsc-bigwigsummary
doc: "Extract summary information from a bigWig file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_file
    type: File
    doc: The input .bw (bigWig) file.
    inputBinding:
      position: 1
  - id: chrom
    type: string
    doc: The chromosome name (e.g. chr1).
    inputBinding:
      position: 2
  - id: start
    type: int
    doc: The start position (0-based).
    inputBinding:
      position: 3
  - id: end
    type: int
    doc: The end position.
    inputBinding:
      position: 4
  - id: data_points
    type: int
    doc: The number of data points to summarize the region into.
    inputBinding:
      position: 5
  - id: type
    type:
      - 'null'
      - string
    doc: 'Summary type: mean, min, max, std, or coverage.'
    inputBinding:
      position: 106
      prefix: -type
  - id: udc_dir
    type:
      - 'null'
      - Directory
    doc: Path to udc cache directory.
    inputBinding:
      position: 106
      prefix: -udcDir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bigwigsummary:482--h0b57e2e_0
stdout: ucsc-bigwigsummary.out
