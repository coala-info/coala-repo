cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - krepp
  - sketch
label: krepp_sketch
doc: "Create a sketch from k-mers in a single FASTA/FASTQ file.\n\nTool homepage: https://github.com/bo1929/krepp"
inputs:
  - id: input_file
    type: File
    doc: "Input FASTA/FASTQ file path (gzip compatible)"
    inputBinding:
      position: 101
      prefix: --input-file
  - id: output_path_path
    type: string
    doc: "Path to store the resulting binary sketch file"
    inputBinding:
      position: 102
      prefix: --output-path
  - id: kmer_len
    type:
      - 'null'
      - int
    doc: "Length of k-mers (19-31) [26]"
    inputBinding:
      position: 101
      prefix: --kmer-len
  - id: win_len
    type:
      - 'null'
      - int
    doc: "Length of minimizer window (w>=k) [k+6]"
    inputBinding:
      position: 101
      prefix: --win-len
  - id: num_positions
    type:
      - 'null'
      - int
    doc: "Number of positions for the LSH [k-16]"
    inputBinding:
      position: 101
      prefix: --num-positions
  - id: modulo_lsh
    type:
      - 'null'
      - int
    doc: "Modulo value to partition LSH space [4]"
    inputBinding:
      position: 101
      prefix: --modulo-lsh
  - id: residue_lsh
    type:
      - 'null'
      - int
    doc: "A k-mer x will be included only if r = LSH(x) mod m [1]"
    inputBinding:
      position: 101
      prefix: --residue-lsh
  - id: frac
    type:
      - 'null'
      - boolean
    doc: "Include k-mers with r <= LSH(x) mod m [true]"
    inputBinding:
      position: 101
      prefix: --frac
  - id: no_frac
    type:
      - 'null'
      - boolean
    doc: "Do not include k-mers with r <= LSH(x) mod m"
    inputBinding:
      position: 101
      prefix: --no-frac
  - id: sdust_t
    type:
      - 'null'
      - int
    doc: "SDUST threshold (NCBI dustmasker: 20) [0]"
    inputBinding:
      position: 101
      prefix: --sdust-t
  - id: sdust_w
    type:
      - 'null'
      - int
    doc: "SDUST window (NCBI dustmasker: 64) [0]"
    inputBinding:
      position: 101
      prefix: --sdust-w
  - id: num_threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use in OpenMP-based parallelism [1]"
    inputBinding:
      position: 101
      prefix: --num-threads
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random seed for the LSH and other parts that require randomness [0]"
    inputBinding:
      position: 101
      prefix: --seed
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Increased verbosity and progress report"
    inputBinding:
      position: 101
      prefix: --verbose
  - id: no_verbose
    type:
      - 'null'
      - boolean
    doc: "Disable increased verbosity and progress report"
    inputBinding:
      position: 101
      prefix: --no-verbose
outputs:
  - id: output_path
    type: File
    doc: "Binary sketch file"
    outputBinding:
      glob: $(inputs.output_path_path)
stdout: krepp_sketch.out
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krepp:0.7.1--hdb29145_0
