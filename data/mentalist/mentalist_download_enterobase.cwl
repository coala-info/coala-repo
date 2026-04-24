cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mentalist
  - download_enterobase
label: mentalist_download_enterobase
doc: "Download scheme data from Enterobase.\n\nTool homepage: https://github.com/WGS-TB/MentaLiST"
inputs:
  - id: db
    type:
      - 'null'
      - File
    doc: Output file (kmer database)
    inputBinding:
      position: 101
      prefix: --db
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Kmer size
    inputBinding:
      position: 101
      prefix: -k
  - id: scheme
    type:
      - 'null'
      - string
    doc: 'Letter identifying which scheme: (S)almonella, (Y)ersinia, or (E)scherichia/Shigella.'
    inputBinding:
      position: 101
      prefix: --scheme
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads used in parallel.
    inputBinding:
      position: 101
      prefix: --threads
  - id: type
    type:
      - 'null'
      - string
    doc: "Choose the type: 'cg' or 'wg' for cgMLST or wgMLST scheme, respectively."
    inputBinding:
      position: 101
      prefix: --type
outputs:
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Output folder for the scheme Fasta files.
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mentalist:0.2.4--h7b50bb2_8
