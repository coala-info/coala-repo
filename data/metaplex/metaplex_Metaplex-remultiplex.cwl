cwlVersion: v1.2
class: CommandLineTool
baseCommand: Metaplex-remultiplex
label: metaplex_Metaplex-remultiplex
doc: "Remultiplexes dual-indexed reads: trims the reads past the indexes and moves the 3' index to immediately follow the 5' index.\n\nTool homepage: https://github.com/NGabry/MetaPlex"
inputs:
  - id: sequence_file
    type: File
    doc: "Path to the raw sequence file (.fastq, .fastq.gz or .bam)."
    inputBinding:
      position: 1
  - id: index_file
    type: File
    doc: "Path to the .csv with all index tag sequences in the sequencing pool (columns ID, seq, orientation)."
    inputBinding:
      position: 2
outputs:
  - id: remultiplexed_seqs
    type: File
    doc: "Remultiplexed reads (remultiplexed_seqs.fastq.gz)"
    outputBinding:
      glob: "remultiplexed_seqs.fastq.gz"
  - id: sorted_fastqs
    type:
      - 'null'
      - Directory
    doc: "Reads sorted by index pair and the cutadapt logs"
    outputBinding:
      glob: "fastqs"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaplex:1.1.0--pyh5e36f6f_0
