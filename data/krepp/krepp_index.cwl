cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - krepp
  - index
label: krepp_index
doc: "Build an index from k-mers of reference genomes.\n\nTool homepage: https://github.com/bo1929/krepp"
inputs:
  - id: input_file
    type: File
    doc: "TSV file mapping reference IDs to (gzip compatible) paths"
    inputBinding:
      position: 101
      prefix: --input-file
  - id: reference_dir
    type: Directory
    doc: "Directory with the reference genomes named in the input file, staged into the working directory (the paths in the TSV file must be relative to it)"
  - id: index_dir
    type: string
    doc: "Directory in which the index will be stored"
    inputBinding:
      position: 102
      prefix: --index-dir
  - id: nwk_file
    type:
      - 'null'
      - File
    doc: "Path to the Newick file for the guide tree (must be rooted)"
    inputBinding:
      position: 101
      prefix: --nwk-file
  - id: kmer_len
    type:
      - 'null'
      - int
    doc: "Length of k-mers (19-31) [29]"
    inputBinding:
      position: 101
      prefix: --kmer-len
  - id: win_len
    type:
      - 'null'
      - int
    doc: "Length of minimizer window (w>k) [k+6]"
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
  - id: index_dir_out
    type: Directory
    doc: "Directory containing the reference index"
    outputBinding:
      glob: $(inputs.index_dir)
  - id: stdout_out
    type: stdout
    doc: "Standard output"
stdout: krepp_index.out
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: "$(inputs.reference_dir)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krepp:0.7.1--hdb29145_0
