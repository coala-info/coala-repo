cwlVersion: v1.2
class: CommandLineTool
baseCommand: goleft
label: goleft_indexsplit
doc: "Splits indexed BAM/CRAM files into smaller regions based on a reference FASTA
  index.\n\nTool homepage: https://github.com/brentp/goleft"
inputs:
  - id: indexes
    type:
      type: array
      items: File
    doc: bai's/crais to use for splitting genome.
    inputBinding:
      position: 1
  - id: fasta_index
    type:
      - 'null'
      - File
    doc: fasta index file.
    inputBinding:
      position: 102
      prefix: --fai
  - id: num_regions
    type: int
    doc: number of regions to split to.
    inputBinding:
      position: 102
      prefix: --n
  - id: problematic_regions
    type:
      - 'null'
      - string
    doc: pipe-delimited list of regions to split small.
    inputBinding:
      position: 102
      prefix: --problematic
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/goleft:0.2.6--he881be0_1
stdout: goleft_indexsplit.out
