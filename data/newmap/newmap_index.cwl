cwlVersion: v1.2
class: CommandLineTool
baseCommand: newmap_index
label: newmap_index
doc: "Create an index for a FASTA file.\n\nTool homepage: https://github.com/hoffmangroup/newmap"
inputs:
  - id: fasta_file
    type: File
    doc: Reference sequence file in FASTA format
    inputBinding:
      position: 1
  - id: compression_ratio
    type:
      - 'null'
      - float
    doc: Compression ratio for suffix array to be sampled. Larger ratios reduce 
      file size and increase the average number of operations per query.
    inputBinding:
      position: 102
      prefix: --compression-ratio
  - id: seed_length
    type:
      - 'null'
      - int
    doc: Length of k-mers to memoize in a lookup table to speed up searches. 
      Each value increase multiplies memory usage of the index by 4.
    inputBinding:
      position: 102
      prefix: --seed-length
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Filename of the index file to write.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/newmap:0.2--py312h9c9b0c2_1
