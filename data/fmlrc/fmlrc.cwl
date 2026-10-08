cwlVersion: v1.2
class: CommandLineTool
baseCommand: fmlrc
label: fmlrc
doc: "FMLRC (FM-index Long Read Corrector) is a tool for correcting long reads (like
  Oxford Nanopore or Pacific Biosciences) using a BWT of short read sequencing data.\n\
  \nTool homepage: https://github.com/holtjma/fmlrc"
inputs:
  - id: comp_msbwt
    type: File
    doc: Compressed multi-string BWT of the short reads (.npy), made with fmlrc-convert
    inputBinding:
      position: 1
  - id: long_reads
    type: File
    doc: Long reads to correct, in FASTA format
    inputBinding:
      position: 2
  - id: corrected_reads_path
    type: string
    doc: Name of the corrected reads FASTA file to write
    inputBinding:
      position: 3
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Small k-mer size (default 21)
    inputBinding:
      position: 101
      prefix: -k
  - id: large_kmer_size
    type:
      - 'null'
      - int
    doc: Large K-mer size (default 59); set K=k for single pass
    inputBinding:
      position: 101
      prefix: -K
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of correction threads
    inputBinding:
      position: 101
      prefix: -p
  - id: begin_index
    type:
      - 'null'
      - int
    doc: Index of the read to start with (default 0)
    inputBinding:
      position: 101
      prefix: -b
  - id: end_index
    type:
      - 'null'
      - int
    doc: Index of the read to end with (default end of file)
    inputBinding:
      position: 101
      prefix: -e
  - id: min_count
    type:
      - 'null'
      - int
    doc: Absolute minimum count to consider a path (default 5)
    inputBinding:
      position: 101
      prefix: -m
  - id: min_fraction
    type:
      - 'null'
      - float
    doc: Dynamic minimum fraction of the median to consider a path (default 0.10)
    inputBinding:
      position: 101
      prefix: -f
  - id: branch_limit
    type:
      - 'null'
      - int
    doc: Set the branch limit to this value times k or K (default 4)
    inputBinding:
      position: 101
      prefix: -B
  - id: sampled_fm_index
    type:
      - 'null'
      - boolean
    doc: Build a sampled FM-index instead of bit arrays
    inputBinding:
      position: 101
      prefix: -i
  - id: fm_index_sampling
    type:
      - 'null'
      - int
    doc: FM-index is sampled every 2**<INT> values (default 8); requires -i
    inputBinding:
      position: 101
      prefix: -F
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 101
      prefix: -V
outputs:
  - id: corrected_reads
    type: File
    doc: Corrected long reads in FASTA format
    outputBinding:
      glob: $(inputs.corrected_reads_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fmlrc:1.0.0--h9948957_6
