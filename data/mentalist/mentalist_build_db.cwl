cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mentalist
  - build_db
label: mentalist_build_db
doc: "Build a kmer database for MLST profiling.\n\nTool homepage: https://github.com/WGS-TB/MentaLiST"
inputs:
  - id: fasta_files
    type:
      type: array
      items: File
    doc: Fasta files with the MLST scheme
    inputBinding:
      position: 1
  - id: k
    type: int
    doc: Kmer size
    inputBinding:
      position: 102
      prefix: -k
  - id: profile
    type:
      - 'null'
      - File
    doc: Profile file for known genotypes.
    inputBinding:
      position: 102
      prefix: --profile
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads used in parallel.
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: db
    type: File
    doc: Output file (kmer database)
    outputBinding:
      glob: $(inputs.db)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mentalist:0.2.4--h7b50bb2_8
