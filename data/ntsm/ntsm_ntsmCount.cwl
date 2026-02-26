cwlVersion: v1.2
class: CommandLineTool
baseCommand: ntsmCount
label: ntsm_ntsmCount
doc: "Count k-mers for SNP sites\n\nTool homepage: https://github.com/JustinChu/ntsm"
inputs:
  - id: fasta
    type:
      - 'null'
      - File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files
    inputBinding:
      position: 2
  - id: allow_shared_kmers
    type:
      - 'null'
      - boolean
    doc: Allow shared k-mers between sites to be counted.
    inputBinding:
      position: 103
      prefix: --dupes
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size used.
    default: 19
    inputBinding:
      position: 103
      prefix: --kmer
  - id: max_coverage
    type:
      - 'null'
      - int
    doc: k-mer coverage threshold for early termination.
    default: inf
    inputBinding:
      position: 103
      prefix: --maxCov
  - id: snp_fasta
    type: string
    doc: Interleaved fasta of SNP sites to k-merize.
    inputBinding:
      position: 103
      prefix: --snp
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to run.
    default: 1
    inputBinding:
      position: 103
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Display verbose output.
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output_summary
    type:
      - 'null'
      - File
    doc: Output for summary file.
    outputBinding:
      glob: $(inputs.output_summary)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ntsm:1.2.1--h077b44d_1
