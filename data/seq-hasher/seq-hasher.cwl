cwlVersion: v1.2
class: CommandLineTool
baseCommand: seq-hasher
label: seq-hasher
doc: "Compute hash digests for sequences in a FASTA file\n\nTool homepage: https://github.com/zszszszsz/.config"
inputs:
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: Input file(s). Use '-' for stdin
    inputBinding:
      position: 1
  - id: circular_kmers
    type:
      - 'null'
      - boolean
    doc: Make hashing robust to circular permutations via addition of the k-mers that
      wrap around the end of the sequence. Works only with --multi-kmer-hashing
    inputBinding:
      position: 102
      prefix: --circular-kmers
  - id: circular_rotation
    type:
      - 'null'
      - boolean
    doc: Make hashing robust to circular permutations via deterministic rotation to
      the lexicographically minimal sequence
    inputBinding:
      position: 102
      prefix: --circular-rotation
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Size of the k-mers to hash when using --multi-kmer-hashing
    inputBinding:
      position: 102
      prefix: --kmer-size
  - id: multi_kmer_hashing
    type:
      - 'null'
      - boolean
    doc: Instead of hashing the entire sequence at once, hash each k-mer individually
      and then combine the resulting hashes
    inputBinding:
      position: 102
      prefix: --multi-kmer-hashing
  - id: print_sequence
    type:
      - 'null'
      - boolean
    doc: Print sequences in a third column
    inputBinding:
      position: 102
      prefix: --print-sequence
  - id: xxhash
    type:
      - 'null'
      - boolean
    doc: Replace ntHash with xxHash for hashing k-mers. Works only with --multi-kmer-hashing
    inputBinding:
      position: 102
      prefix: --xxhash
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seq-hasher:0.2.0--h4349ce8_0
stdout: seq-hasher.out
