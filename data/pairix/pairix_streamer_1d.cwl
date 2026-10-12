cwlVersion: v1.2
class: CommandLineTool
baseCommand: streamer_1d
label: pairix_streamer_1d
doc: "Resorter: convert a file sorted by chr1-chr2-pos1-pos2 to a stream sorted by
  chr1-pos1 (written to standard output; pipe through bgzip to compress).\n\nTool homepage:
  https://github.com/4dn-dcic/pairix"
inputs:
  - id: input_pairs_file
    type: File
    doc: Input 2D-sorted bgzipped pairs file with its .px2 index
    secondaryFiles:
      - .px2
    inputBinding:
      position: 1
outputs:
  - id: stream_1d
    type: stdout
    doc: Pairs sorted by chr1-pos1 (uncompressed)
stdout: out.1d.pairs
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pairix:0.3.9--py312h4711d71_0
