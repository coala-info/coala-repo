cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sinto
  - addtags
label: sinto_addtags
doc: "Add read tags to reads from individual cells\n\nTool homepage: https://timoast.github.io/sinto/"
inputs:
  - id: bam_file
    type: File
    doc: Input bam file (must be indexed)
    inputBinding:
      position: 101
      prefix: --bam
  - id: mode
    type:
      - 'null'
      - string
    doc: Either tag (default) or readname. Some BAM file store the cell barcode 
      in the readname rather than under a read tag
    default: tag
    inputBinding:
      position: 101
      prefix: --mode
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of processors (default = 1)
    default: 1
    inputBinding:
      position: 101
      prefix: --nproc
  - id: sam
    type:
      - 'null'
      - boolean
    doc: Output sam format (default bam output)
    inputBinding:
      position: 101
      prefix: --sam
  - id: tagfile
    type: File
    doc: Tab-delimited file containing cell barcode, tag to be added, and tag 
      identity. Can be gzip compressed
    inputBinding:
      position: 101
      prefix: --tagfile
  - id: trim_suffix
    type:
      - 'null'
      - boolean
    doc: Remove trail 2 characters from cell barcode in BAM file
    inputBinding:
      position: 101
      prefix: --trim_suffix
outputs:
  - id: output
    type: File
    doc: Name for output text file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sinto:0.10.1--pyhdfd78af_0
