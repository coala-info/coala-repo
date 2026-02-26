cwlVersion: v1.2
class: CommandLineTool
baseCommand: magpurify gc-content
label: magpurify_gc-content
doc: "Find contigs with outlier GC content.\n\nTool homepage: https://github.com/snayfach/MAGpurify"
inputs:
  - id: fna
    type: File
    doc: Path to input genome in FASTA format
    inputBinding:
      position: 1
  - id: cutoff
    type:
      - 'null'
      - float
    doc: Cutoff
    default: 15.75
    inputBinding:
      position: 102
      prefix: --cutoff
  - id: weighted_mean
    type:
      - 'null'
      - boolean
    doc: Compute the mean weighted by the contig length
    default: false
    inputBinding:
      position: 102
      prefix: --weighted-mean
outputs:
  - id: out
    type: Directory
    doc: Output directory to store results and intermediate files
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/magpurify:2.1.2--pyhdfd78af_2
