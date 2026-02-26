cwlVersion: v1.2
class: CommandLineTool
baseCommand: makebins
label: mosaicatcher_makebins
doc: "Specify whole genome sequencing data (or a set of Strand-seq cells\nmerged into
  a single file) which were sequenced under equal conditions.\nThis tool will create
  bins of variable width but which contian the same\nnumber of reads. This way we
  hope to overcome mappability issues.\n\nTool homepage: https://github.com/friendsofstrandseq/mosaicatcher/"
inputs:
  - id: wgs_bam
    type: File
    doc: Whole genome sequencing BAM file
    inputBinding:
      position: 1
  - id: exclude
    type:
      - 'null'
      - string
    doc: Exclude chromosomes (no regions!)
    inputBinding:
      position: 102
      prefix: --exclude
  - id: mapq
    type:
      - 'null'
      - int
    doc: min mapping quality
    default: 10
    inputBinding:
      position: 102
      prefix: --mapq
  - id: numreads
    type:
      - 'null'
      - int
    doc: sample 1/n of reads (reduce memory)
    default: 20
    inputBinding:
      position: 102
      prefix: --numreads
  - id: window
    type:
      - 'null'
      - int
    doc: window size to approximate
    default: 100000
    inputBinding:
      position: 102
      prefix: --window
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: output file for bins
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mosaicatcher:0.3.1--h66ab1b6_2
