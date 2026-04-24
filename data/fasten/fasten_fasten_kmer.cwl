cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasten_kmer
label: fasten_fasten_kmer
doc: "Counts kmers.\n\nTool homepage: https://github.com/lskatz/fasten"
inputs:
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: The size of the kmer
    inputBinding:
      position: 101
      prefix: --kmer-length
  - id: numcpus
    type:
      - 'null'
      - int
    doc: Number of CPUs
    inputBinding:
      position: 101
      prefix: --numcpus
  - id: paired_end
    type:
      - 'null'
      - boolean
    doc: The input reads are interleaved paired-end
    inputBinding:
      position: 101
      prefix: --paired-end
  - id: remember_reads
    type:
      - 'null'
      - boolean
    doc: "Add reads to subsequent columns. Each read begins with\nthe kmer. Only lists
      reads in the forward direction."
    inputBinding:
      position: 101
      prefix: --remember-reads
  - id: revcomp
    type:
      - 'null'
      - boolean
    doc: Count kmers on the reverse complement strand too
    inputBinding:
      position: 101
      prefix: --revcomp
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print more status messages
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasten:0.9.0--hc1c3326_0
stdout: fasten_fasten_kmer.out
