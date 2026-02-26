cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/WGA
label: alloshp_WGA
doc: "Whole Genome Alignment tool for comparing two genomes\n\nTool homepage: https://github.com/eead-csic-compbio/AlloSHP"
inputs:
  - id: cgaln_aligner_params
    type:
      - 'null'
      - string
    doc: parameters for Cgaln aligner
    default: -X4000
    inputBinding:
      position: 101
      prefix: -C
  - id: cgaln_indexer_params
    type:
      - 'null'
      - string
    doc: parameters for Cgaln indexer
    default: -K11 -BS10000
    inputBinding:
      position: 101
      prefix: -N
  - id: genome_a
    type: File
    doc: 'FASTA file of genome A (example: -A speciesA.fna[.gz])'
    inputBinding:
      position: 101
      prefix: -A
  - id: genome_b
    type: File
    doc: 'FASTA file of genome B (example: -B speciesB.fna[.gz])'
    inputBinding:
      position: 101
      prefix: -B
  - id: gsalign_aligner_params
    type:
      - 'null'
      - string
    doc: parameters for GSAlign aligner
    default: -no_vcf -one
    inputBinding:
      position: 101
      prefix: -G
  - id: mapcoords_params
    type:
      - 'null'
      - string
    doc: 'parameters for utils/mapcoords.pl (1st: max ratio of mapped positions in
      other blocks, 2nd: max ratio of coordinates with multiple positions in same
      block)'
    default: 0.25 0.05
    inputBinding:
      position: 101
      prefix: -M
  - id: min_contig_length
    type:
      - 'null'
      - float
    doc: min contig length [Mbp]
    default: 1
    inputBinding:
      position: 101
      prefix: -l
  - id: num_cores
    type:
      - 'null'
      - int
    doc: number of cores (optional, some tasks only)
    default: 4
    inputBinding:
      position: 101
      prefix: -n
  - id: print_credits
    type:
      - 'null'
      - boolean
    doc: print credits and checks install
    inputBinding:
      position: 101
      prefix: -c
  - id: soft_masked
    type:
      - 'null'
      - boolean
    doc: 'FASTA files already soft-masked (optional, default: masked with Red)'
    inputBinding:
      position: 101
      prefix: -m
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: path to dir for temp files
    default: /tmp
    inputBinding:
      position: 101
      prefix: -t
  - id: use_gsalign
    type:
      - 'null'
      - boolean
    doc: 'use multithreaded GSAlign algorithm (optional, default: Cgaln)'
    inputBinding:
      position: 101
      prefix: -g
outputs:
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: 'output folder (optional, default: speciesA.speciesB)'
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alloshp:2025.09.12--h7b50bb2_0
