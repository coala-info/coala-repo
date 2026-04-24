cwlVersion: v1.2
class: CommandLineTool
baseCommand: TideHunter
label: tidehunter_TideHunter
doc: "Tandem repeats detection and consensus calling from noisy long reads\n\nTool
  homepage: https://github.com/yangao07/TideHunter"
inputs:
  - id: input_file
    type: File
    doc: Input FASTA/FASTQ file
    inputBinding:
      position: 1
  - id: ada_mat_rat
    type:
      - 'null'
      - float
    doc: minimum match ratio of adapter sequence
    inputBinding:
      position: 102
      prefix: --ada-mat-rat
  - id: five_prime_adapter
    type:
      - 'null'
      - string
    doc: 5' adapter sequence (sense strand)
    inputBinding:
      position: 102
      prefix: --five-prime
  - id: full_len
    type:
      - 'null'
      - boolean
    doc: only output full-length consensus sequence.
    inputBinding:
      position: 102
      prefix: --full-len
  - id: gap_ext
    type:
      - 'null'
      - string
    doc: gap extension penalty (E1,E2)
    inputBinding:
      position: 102
      prefix: --gap-ext
  - id: gap_open
    type:
      - 'null'
      - string
    doc: gap opening penalty (O1,O2)
    inputBinding:
      position: 102
      prefix: --gap-open
  - id: hpc_kmer
    type:
      - 'null'
      - boolean
    doc: use homopolymer-compressed k-mer
    inputBinding:
      position: 102
      prefix: --HPC-kmer
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: k-mer length (no larger than 16)
    inputBinding:
      position: 102
      prefix: --kmer-length
  - id: longest
    type:
      - 'null'
      - boolean
    doc: only output consensus sequence of tandem repeat that covers the longest
      read sequence
    inputBinding:
      position: 102
      prefix: --longest
  - id: match
    type:
      - 'null'
      - int
    doc: match score
    inputBinding:
      position: 102
      prefix: --match
  - id: max_diverg
    type:
      - 'null'
      - float
    doc: maximum allowed divergence rate between two consecutive repeats
    inputBinding:
      position: 102
      prefix: --max-diverg
  - id: max_period
    type:
      - 'null'
      - int
    doc: maximum period size of tandem repeat (<=4294967295)
    inputBinding:
      position: 102
      prefix: --max-period
  - id: min_copy
    type:
      - 'null'
      - int
    doc: minimum copy number of tandem repeat (>=2)
    inputBinding:
      position: 102
      prefix: --min-copy
  - id: min_cov
    type:
      - 'null'
      - string
    doc: only output consensus sequence with at least R supporting units for all
      bases
    inputBinding:
      position: 102
      prefix: --min-cov
  - id: min_len
    type:
      - 'null'
      - int
    doc: only output consensus sequence with min. length of
    inputBinding:
      position: 102
      prefix: --min-len
  - id: min_period
    type:
      - 'null'
      - int
    doc: minimum period size of tandem repeat (>=2)
    inputBinding:
      position: 102
      prefix: --min-period
  - id: mismatch
    type:
      - 'null'
      - int
    doc: mismatch penalty
    inputBinding:
      position: 102
      prefix: --mismatch
  - id: out_fmt
    type:
      - 'null'
      - int
    doc: output format
    inputBinding:
      position: 102
      prefix: --out-fmt
  - id: single_copy
    type:
      - 'null'
      - boolean
    doc: output additional single-copy full-length consensus sequence.
    inputBinding:
      position: 102
      prefix: --single-copy
  - id: thread
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 102
      prefix: --thread
  - id: three_prime_adapter
    type:
      - 'null'
      - string
    doc: 3' adapter sequence (anti-sense strand)
    inputBinding:
      position: 102
      prefix: --three-prime
  - id: unit_seq
    type:
      - 'null'
      - boolean
    doc: only output unit sequences of each tandem repeat, no consensus sequence
    inputBinding:
      position: 102
      prefix: --unit-seq
  - id: window_size
    type:
      - 'null'
      - int
    doc: window size, set as >1 to enable minimizer seeding
    inputBinding:
      position: 102
      prefix: --window-size
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tidehunter:1.5.5--h5ca1c30_3
