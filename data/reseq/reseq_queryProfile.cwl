cwlVersion: v1.2
class: CommandLineTool
baseCommand: reseq queryProfile
label: reseq_queryProfile
doc: "Runs ReSeq in queryProfile mode\n\nTool homepage: https://github.com/schmeing/ReSeq/tree/devel"
inputs:
  - id: max_len_deletion
    type:
      - 'null'
      - boolean
    doc: Output lengths of longest detected deletion to stdout
    inputBinding:
      position: 101
      prefix: --maxLenDeletion
  - id: max_read_length
    type:
      - 'null'
      - boolean
    doc: Output lengths of longest detected read to stdout
    inputBinding:
      position: 101
      prefix: --maxReadLength
  - id: ref
    type: File
    doc: Reference sequences in fasta format (gz and bz2 supported)
    inputBinding:
      position: 101
      prefix: --ref
  - id: stats
    type: File
    doc: Reseq statistics file to extract reference sequence bias
    inputBinding:
      position: 101
      prefix: --stats
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads used (0=auto)
    default: 0
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Sets the level of verbosity (4=everything, 0=nothing)
    default: 4
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: ref_seq_bias
    type:
      - 'null'
      - File
    doc: Output reference sequence bias to file (tsv format; - for stdout)
    outputBinding:
      glob: $(inputs.ref_seq_bias)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reseq:1.1--py310hfb68e69_5
