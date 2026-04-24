cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - votuderep
  - derep
label: votuderep_derep
doc: "Dereplicate vOTUs using BLAST and ANI clustering.\nThis command: 1. Creates
  a BLAST database from input sequences 2. Performs\nall-vs-all BLAST comparison 3.
  Calculates ANI and coverage for sequence pairs\n4. Clusters sequences by ANI using
  greedy algorithm 5. Outputs cluster\nrepresentatives (longest sequences)\nThe algorithm
  selects the longest sequence from each cluster as the\nrepresentative, effectively
  removing shorter redundant sequences.\n\nTool homepage: https://github.com/quadram-institute-bioscience/votuderep"
inputs:
  - id: input
    type: File
    doc: Input FASTA file containing vOTUs
    inputBinding:
      position: 101
      prefix: --input
  - id: keep
    type:
      - 'null'
      - boolean
    doc: Keep the temporary directory after completion
    inputBinding:
      position: 101
      prefix: --keep
  - id: min_ani
    type:
      - 'null'
      - float
    doc: Minimum ANI to consider two vOTUs as the same
    inputBinding:
      position: 101
      prefix: --min-ani
  - id: min_tcov
    type:
      - 'null'
      - float
    doc: Minimum target coverage to consider two vOTUs as the same
    inputBinding:
      position: 101
      prefix: --min-tcov
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for BLAST
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmp
    type:
      - 'null'
      - Directory
    doc: Directory for temporary files
    inputBinding:
      position: 101
      prefix: --tmp
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output FASTA file with dereplicated vOTUs
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/votuderep:0.6.0--pyhdfd78af_0
