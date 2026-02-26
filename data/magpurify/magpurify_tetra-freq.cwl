cwlVersion: v1.2
class: CommandLineTool
baseCommand: magpurify tetra-freq
label: magpurify_tetra-freq
doc: "Find contigs with outlier tetranucleotide frequency.\n\nTool homepage: https://github.com/snayfach/MAGpurify"
inputs:
  - id: fna
    type: File
    doc: Path to input genome in FASTA format
    inputBinding:
      position: 1
  - id: out
    type: Directory
    doc: Output directory to store results and intermediate files
    inputBinding:
      position: 2
  - id: cutoff
    type:
      - 'null'
      - float
    doc: Cutoff
    default: 0.06
    inputBinding:
      position: 103
      prefix: --cutoff
  - id: weighted_mean
    type:
      - 'null'
      - boolean
    doc: Compute the mean weighted by the contig length
    default: false
    inputBinding:
      position: 103
      prefix: --weighted-mean
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/magpurify:2.1.2--pyhdfd78af_2
stdout: magpurify_tetra-freq.out
