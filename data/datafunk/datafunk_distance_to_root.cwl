cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - datafunk
  - distance_to_root
label: datafunk_distance_to_root
doc: "calculates per sample genetic distance to WH04 and writes it to 'distances.tsv'\n\
  \nTool homepage: https://github.com/cov-ert/datafunk"
inputs:
  - id: input_fasta
    type: File
    doc: Fasta file to read. Must be aligned to Wuhan-Hu-1
    inputBinding:
      position: 101
      prefix: --input-fasta
  - id: input_metadata
    type: File
    doc: Metadata to read. Must contain epi week information
    inputBinding:
      position: 101
      prefix: --input-metadata
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
stdout: datafunk_distance_to_root.out
