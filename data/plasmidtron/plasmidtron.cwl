cwlVersion: v1.2
class: CommandLineTool
baseCommand: plasmidtron
label: plasmidtron
doc: "Plasmidtron: identify plasmids from whole genome sequencing data using k-mer
  analysis.\n\nTool homepage: https://github.com/sanger-pathogens/plasmidtron"
inputs:
  - id: assembler
    type:
      - 'null'
      - string
    doc: Assembler to use (spades or velvet)
    default: spades
    inputBinding:
      position: 101
      prefix: --assembler
  - id: control_files
    type:
      type: array
      items: File
    doc: FASTA files for the control (e.g., samples without the trait)
    inputBinding:
      position: 101
      prefix: --control
  - id: fasta_files
    type:
      type: array
      items: File
    doc: FASTA files for the trait of interest (e.g., plasmid-containing 
      samples)
    inputBinding:
      position: 101
      prefix: --fasta
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: K-mer size for analysis
    default: 51
    inputBinding:
      position: 101
      prefix: --kmer
  - id: memory
    type:
      - 'null'
      - int
    doc: Maximum memory in GB
    inputBinding:
      position: 101
      prefix: --memory
  - id: min_kmer_occurrence
    type:
      - 'null'
      - int
    doc: Minimum number of times a k-mer must occur in the trait samples
    default: 1
    inputBinding:
      position: 101
      prefix: --min_kmer_occurrence
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files
    inputBinding:
      position: 101
      prefix: --prefix
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasmidtron:0.4.1--py36_1
