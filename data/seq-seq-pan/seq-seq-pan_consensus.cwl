cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seq-seq-pan-consensus
label: seq-seq-pan_consensus
doc: "Consensus genome construction from a whole genome alignment (XMFA file). Writes
  INPUT_consensus.fasta, its .idx index, and the block-separated FASTA with its .idx
  index.\n\nTool homepage: https://gitlab.com/chrjan/seq-seq-pan"
inputs:
  - id: xmfa
    type: File
    doc: XMFA input file (the tool writes its results next to it, so it is staged
      in the working directory)
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
outputs:
  - id: consensus_fasta
    type: File
    doc: Consensus FASTA file
    outputBinding:
      glob: $(inputs.xmfa.nameroot)_consensus.fasta
  - id: consensus_index
    type: File
    doc: Consensus index file
    outputBinding:
      glob: $(inputs.xmfa.nameroot)_consensus.fasta.idx
  - id: blockseparated_fasta
    type: File
    doc: Consensus FASTA with blocks separated by delimiter sequences
    outputBinding:
      glob: $(inputs.xmfa.nameroot)_consensus.fasta.blockseparated.fasta
  - id: blockseparated_index
    type: File
    doc: Index file of the block-separated consensus FASTA
    outputBinding:
      glob: $(inputs.xmfa.nameroot)_consensus.fasta.blockseparated.idx
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.xmfa)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seq-seq-pan:1.1.0--py_1
