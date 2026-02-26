cwlVersion: v1.2
class: CommandLineTool
baseCommand: krepp sketch
label: krepp_sketch
doc: "Create a sketch from k-mers in a single FASTA/FASTQ file.\n\nTool homepage:
  https://github.com/bo1929/krepp"
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
  - id: input_file
    type: File
    doc: Input FASTA/FASTQ file <path> (or URL) (gzip compatible).
    inputBinding:
      position: 101
      prefix: --input-file
  - id: kmer_len
    type:
      - 'null'
      - int
    doc: Length of k-mers.
    default: 26
    inputBinding:
      position: 101
      prefix: --kmer-len
  - id: modulo_lsh
    type:
      - 'null'
      - int
    doc: Modulo value to partition LSH space.
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
    doc: Length of minimizer window (w>=k).
    default: k+6
    inputBinding:
      position: 101
      prefix: --win-len
outputs:
  - id: output_path
    type: File
    doc: Path to store the resulting binary sketch file.
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krepp:0.7.1--hdb29145_0
