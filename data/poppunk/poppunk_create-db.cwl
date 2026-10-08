cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - poppunk
label: poppunk_create-db
doc: "Create a database of k-mer sketches and pairwise core/accessory distances between reference\
  \ assemblies (poppunk --create-db).\n\nTool homepage: https://github.com/johnlees/PopPUNK"
arguments:
  - position: 100
    valueFrom: --create-db
inputs:
  - id: r_files
    type: File
    doc: 'File listing reference input assemblies: sample name and assembly file name per
      line, tab separated.'
    inputBinding:
      position: 101
      prefix: --r-files
  - id: assemblies
    type:
      type: array
      items: File
    doc: Assembly (or read) files named in r_files; staged in the working directory so the
      names resolve.
  - id: output
    type: string
    doc: Output folder (prefix for output files).
    default: poppunk_db
    inputBinding:
      position: 101
      prefix: --output
  - id: plot_fit
    type:
      - 'null'
      - int
    doc: Create this many plots of some fits relating k-mer to core/accessory distances [default
      = 0].
    inputBinding:
      position: 101
      prefix: --plot-fit
  - id: min_k
    type:
      - 'null'
      - int
    doc: Minimum kmer length [default = 13].
    inputBinding:
      position: 101
      prefix: --min-k
  - id: max_k
    type:
      - 'null'
      - int
    doc: Maximum kmer length [default = 29].
    inputBinding:
      position: 101
      prefix: --max-k
  - id: k_step
    type:
      - 'null'
      - int
    doc: K-mer step size [default = 4].
    inputBinding:
      position: 101
      prefix: --k-step
  - id: sketch_size
    type:
      - 'null'
      - int
    doc: Kmer sketch size [default = 10000].
    inputBinding:
      position: 101
      prefix: --sketch-size
  - id: codon_phased
    type:
      - 'null'
      - boolean
    doc: Used codon phased seeds X--X--X.
    inputBinding:
      position: 101
      prefix: --codon-phased
  - id: min_kmer_count
    type:
      - 'null'
      - int
    doc: Minimum k-mer count when using reads as input [default = 0].
    inputBinding:
      position: 101
      prefix: --min-kmer-count
  - id: exact_count
    type:
      - 'null'
      - boolean
    doc: Use the exact k-mer counter with reads.
    inputBinding:
      position: 101
      prefix: --exact-count
  - id: strand_preserved
    type:
      - 'null'
      - boolean
    doc: Treat input as being on the same strand, and ignore reverse complement k-mers.
    inputBinding:
      position: 101
      prefix: --strand-preserved
  - id: gpu_sketch
    type:
      - 'null'
      - boolean
    doc: Use a GPU when calculating sketches (read data only).
    inputBinding:
      position: 101
      prefix: --gpu-sketch
  - id: gpu_dist
    type:
      - 'null'
      - boolean
    doc: Use a GPU when calculating distances.
    inputBinding:
      position: 101
      prefix: --gpu-dist
  - id: deviceid
    type:
      - 'null'
      - int
    doc: CUDA device ID, if using GPU [default = 0].
    inputBinding:
      position: 101
      prefix: --deviceid
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use [default = 1].
    inputBinding:
      position: 101
      prefix: --threads
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite any existing database files.
    inputBinding:
      position: 101
      prefix: --overwrite
outputs:
  - id: output_dir
    type: Directory
    doc: Output folder.
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.assemblies)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poppunk:2.7.8--py310h4d0eb5b_0
