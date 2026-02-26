cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kitsune
  - kopt
label: kitsune_kopt
doc: "Kopt is a tool for optimizing K-mer counts.\n\nTool homepage: https://github.com/natapol/kitsune"
inputs:
  - id: input_file
    type: File
    doc: Input FASTA or FASTQ file
    inputBinding:
      position: 1
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: Length of K-mers to consider
    default: 31
    inputBinding:
      position: 102
      prefix: --kmer-length
  - id: min_count
    type:
      - 'null'
      - int
    doc: Minimum count for a K-mer to be considered
    default: 2
    inputBinding:
      position: 102
      prefix: --min-count
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type: File
    doc: Output file for optimized K-mer counts
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kitsune:1.3.5--pyhdfd78af_0
