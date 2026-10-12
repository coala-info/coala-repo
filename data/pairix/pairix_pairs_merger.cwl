cwlVersion: v1.2
class: CommandLineTool
baseCommand: pairs_merger
label: pairix_pairs_merger
doc: "Merge several sorted, indexed pairs files into one sorted stream (written to
  standard output; pipe through bgzip to compress).\n\nTool homepage: https://github.com/4dn-dcic/pairix"
inputs:
  - id: input_pairs_files
    type:
      type: array
      items: File
    doc: Input bgzipped pairs files, each with its .px2 index
    secondaryFiles:
      - .px2
    inputBinding:
      position: 1
outputs:
  - id: merged_pairs
    type: stdout
    doc: Merged pairs (uncompressed)
stdout: merged.pairs
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pairix:0.3.9--py312h4711d71_0
