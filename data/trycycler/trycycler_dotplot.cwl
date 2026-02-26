cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - trycycler
  - dotplot
label: trycycler_dotplot
doc: "draw pairwise dotplots for a cluster\n\nTool homepage: https://github.com/rrwick/Trycycler"
inputs:
  - id: cluster_dir
    type: Directory
    doc: Cluster directory (should contain a 1_contigs subdirectory)
    inputBinding:
      position: 101
      prefix: --cluster_dir
  - id: kmer
    type:
      - 'null'
      - int
    doc: K-mer size to use in dot plots
    default: 32
    inputBinding:
      position: 101
      prefix: --kmer
  - id: res
    type:
      - 'null'
      - int
    doc: Size (in pixels) of each dot plot image
    default: 2000
    inputBinding:
      position: 101
      prefix: --res
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trycycler:0.5.6--pyhdfd78af_0
stdout: trycycler_dotplot.out
