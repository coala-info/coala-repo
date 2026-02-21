cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigWigInfo
label: ucsc-bigwiginfo
doc: "Get information about a bigWig file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_file
    type: File
    doc: The input .bw (bigWig) file.
    inputBinding:
      position: 1
  - id: chroms
    type:
      - 'null'
      - boolean
    doc: List all chromosomes and their sizes.
    inputBinding:
      position: 102
      prefix: -chroms
  - id: min_max
    type:
      - 'null'
      - boolean
    doc: List just the min and max values.
    inputBinding:
      position: 102
      prefix: -minMax
  - id: summary
    type:
      - 'null'
      - boolean
    doc: List summary information.
    inputBinding:
      position: 102
      prefix: -summary
  - id: udc_dir
    type:
      - 'null'
      - Directory
    doc: Specify directory for udc cache.
    inputBinding:
      position: 102
      prefix: -udcDir
  - id: zooms
    type:
      - 'null'
      - boolean
    doc: List all zoom levels and their sizes.
    inputBinding:
      position: 102
      prefix: -zooms
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bigwiginfo:482--h0b57e2e_0
stdout: ucsc-bigwiginfo.out
