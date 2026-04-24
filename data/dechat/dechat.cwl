cwlVersion: v1.2
class: CommandLineTool
baseCommand: dechat
label: dechat
doc: "Repeat and haplotype aware error correction in nanopore sequencing reads with
  DeChat\n\nTool homepage: https://github.com/LuoGroup2023/DeChat"
inputs:
  - id: correction_round
    type:
      - 'null'
      - int
    doc: round of correction in alignment
    inputBinding:
      position: 101
      prefix: -r
  - id: input_reads
    type: File
    doc: input reads file
    inputBinding:
      position: 101
      prefix: -i
  - id: input_reads_for_dbg
    type:
      - 'null'
      - File
    doc: input reads file for building dBG (Default use input ONT reads)
    inputBinding:
      position: 101
      prefix: -d
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: k-mer length (must be <64)
    inputBinding:
      position: 101
      prefix: -k
  - id: max_error_rate
    type:
      - 'null'
      - float
    doc: maximum allowed error rate used for filtering overlaps
    inputBinding:
      position: 101
      prefix: -e
  - id: maximal_abundance_threshold
    type:
      - 'null'
      - boolean
    doc: set the maximal abundance threshold for a k-mer in dBG
    inputBinding:
      position: 101
      prefix: -r1
  - id: output_prefix
    type: string
    doc: prefix of output files
    inputBinding:
      position: 101
      prefix: -o
  - id: threads
    type: int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dechat:1.0.1--h56e2c18_1
stdout: dechat.out
