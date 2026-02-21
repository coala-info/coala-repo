cwlVersion: v1.2
class: CommandLineTool
baseCommand: aliceasm
label: aliceasm
doc: "Alice Assembler: a tool for genome assembly using MSR compression and k-mer
  analysis.\n\nTool homepage: https://github.com/RolandFaure/alice-asm"
inputs:
  - id: bcalm_path
    type:
      - 'null'
      - File
    doc: path to bcalm
    default: bcalm
    inputBinding:
      position: 101
      prefix: --bcalm
  - id: clean
    type:
      - 'null'
      - boolean
    doc: remove the tmp folder at the end
    inputBinding:
      position: 101
      prefix: --clean
  - id: compression
    type:
      - 'null'
      - int
    doc: compression factor
    default: 20
    inputBinding:
      position: 101
      prefix: --compression
  - id: kmer_sizes
    type:
      - 'null'
      - string
    doc: comma-separated increasing sizes of k for assembly, must go at least to 31
    default: 17,31
    inputBinding:
      position: 101
      prefix: --kmer-sizes
  - id: min_abundance
    type:
      - 'null'
      - int
    doc: minimum abundance of kmer to consider solid - RECOMMENDED to set to coverage/2
      if single-genome
    default: 5
    inputBinding:
      position: 101
      prefix: --min-abundance
  - id: no_hpc
    type:
      - 'null'
      - boolean
    doc: turn off homopolymer and homodimer compression
    inputBinding:
      position: 101
      prefix: --no-hpc
  - id: order
    type:
      - 'null'
      - int
    doc: order of MSR compression (odd)
    default: 101
    inputBinding:
      position: 101
      prefix: --order
  - id: reads
    type: File
    doc: input file (fasta/q)
    inputBinding:
      position: 101
      prefix: --reads
  - id: single_genome
    type:
      - 'null'
      - boolean
    doc: Switch on if assembling a single genome
    inputBinding:
      position: 101
      prefix: --single-genome
  - id: test_reference
    type:
      - 'null'
      - File
    doc: (developers only) to compare the result against this reference
    inputBinding:
      position: 101
      prefix: --test
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type: Directory
    doc: output folder
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aliceasm:0.6.41--h9948957_0
