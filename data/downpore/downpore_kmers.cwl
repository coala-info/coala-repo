cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - downpore
  - kmers
label: downpore_kmers
doc: "Measures per-k-mer read accuracy from reads aligned to a reference (SAM) and
  writes heatmaps of accuracy against k-mer order, base quality, strand balance and
  (with training data) trained accuracy. Heatmap files are named after the SAM file:
  <alignment>_lex_<k>.txt, <alignment>_qual_<k>.txt, <alignment>_bal_<k>.txt,
  <alignment>_train_<k>.txt. Summary statistics go to stdout.\n\nTool homepage: https://github.com/jteutenberg/downpore"
inputs:
  - id: input
    type: File
    doc: Reads input file (fasta/fastq, one line per sequence)
    inputBinding:
      position: 101
      prefix: -input
  - id: alignment
    type: File
    doc: SAM input file with the reads aligned to the reference
    inputBinding:
      position: 101
      prefix: -alignment
      valueFrom: $(self.basename)
  - id: reference
    type: File
    doc: Reference fasta file (one line per sequence)
    inputBinding:
      position: 101
      prefix: -reference
  - id: training
    type:
      - 'null'
      - File
    doc: Training input file
    inputBinding:
      position: 101
      prefix: -training
  - id: training_alignment
    type:
      - 'null'
      - File
    doc: SAM training file
    inputBinding:
      position: 101
      prefix: -training_alignment
  - id: training_ref
    type:
      - 'null'
      - File
    doc: Training reference fasta file
    inputBinding:
      position: 101
      prefix: -training_ref
  - id: k
    type:
      - 'null'
      - int
    doc: K-mer size (default 10)
    inputBinding:
      position: 101
      prefix: -k
  - id: map_size
    type:
      - 'null'
      - int
    doc: Dimensions for heatmaps (default 100; used when k is 8 or less)
    inputBinding:
      position: 101
      prefix: -map_size
  - id: num_workers
    type:
      - 'null'
      - int
    doc: Number of worker threads to use (default 4)
    inputBinding:
      position: 101
      prefix: -num_workers
  - id: log_file_path
    type:
      - 'null'
      - string
    doc: Name of the file that receives the summary statistics written to stdout
    default: downpore_kmers.log
outputs:
  - id: heatmaps
    type: File[]
    doc: Heatmap files (x y count per line) written beside the SAM file
    outputBinding:
      glob: $(inputs.alignment.basename)_*_*.txt
  - id: log_file
    type: File
    doc: Summary statistics (means, correlations) printed by the tool
    outputBinding:
      glob: $(inputs.log_file_path)
stdout: $(inputs.log_file_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.alignment)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/downpore:0.3.4--h375a9b1_0
