cwlVersion: v1.2
class: CommandLineTool
baseCommand: krepp index
label: krepp_index
doc: "Build an index from k-mers of reference genomes.\n\nTool homepage: https://github.com/bo1929/krepp"
inputs:
  - id: frac
    type:
      - 'null'
      - boolean
    doc: Include k-mers with r <= LSH(x) mod m.
    default: true
    inputBinding:
      position: 101
      prefix: --frac
  - id: index_dir
    type: Directory
    doc: Directory <path> in which the index will be stored.
    inputBinding:
      position: 101
      prefix: --index-dir
  - id: input_file
    type: File
    doc: TSV file <path> mapping reference IDs to (gzip compatible) paths/URLs.
    inputBinding:
      position: 101
      prefix: --input-file
  - id: kmer_len
    type:
      - 'null'
      - int
    doc: Length of k-mers.
    default: 29
    inputBinding:
      position: 101
      prefix: --kmer-len
  - id: modulo_lsh
    type:
      - 'null'
      - int
    doc: Mudulo value to partition LSH space.
    default: 4
    inputBinding:
      position: 101
      prefix: --modulo-lsh
  - id: no_frac
    type:
      - 'null'
      - boolean
    doc: Include k-mers with r <= LSH(x) mod m.
    default: false
    inputBinding:
      position: 101
      prefix: --no-frac
  - id: num_positions
    type:
      - 'null'
      - int
    doc: Number of positions for the LSH.
    default: k-16
    inputBinding:
      position: 101
      prefix: --num-positions
  - id: nwk_file
    type:
      - 'null'
      - File
    doc: Path to the Newick file for the guide tree (must be rooted).
    inputBinding:
      position: 101
      prefix: --nwk-file
  - id: residue_lsh
    type:
      - 'null'
      - int
    doc: A k-mer x will be included only if r = LSH(x) mod m.
    default: 1
    inputBinding:
      position: 101
      prefix: --residue-lsh
  - id: sdust_t
    type:
      - 'null'
      - int
    doc: 'SDUST threshold (NCBI dustmasker: 20).'
    default: 0
    inputBinding:
      position: 101
      prefix: --sdust-t
  - id: sdust_w
    type:
      - 'null'
      - int
    doc: 'SDUST window (NCBI dustmasker: 64).'
    default: 0
    inputBinding:
      position: 101
      prefix: --sdust-w
  - id: win_len
    type:
      - 'null'
      - int
    doc: Length of minimizer window (w>k).
    default: k+6
    inputBinding:
      position: 101
      prefix: --win-len
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krepp:0.7.1--hdb29145_0
stdout: krepp_index.out
