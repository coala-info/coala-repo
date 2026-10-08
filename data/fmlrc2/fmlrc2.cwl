cwlVersion: v1.2
class: CommandLineTool
baseCommand: fmlrc2
label: fmlrc2
doc: "FM-index Long Read Corrector - Rust implementation\n\nTool homepage: https://github.com/HudsonAlpha/fmlrc2"
inputs:
  - id: compressed_msbwt_file
    type: File
    doc: The compressed BWT file with high accuracy reads
    inputBinding:
      position: 1
  - id: long_reads_file
    type: File
    doc: The FASTX file with uncorrected reads
    inputBinding:
      position: 2
  - id: corrected_reads_path
    type: string
    doc: The FASTA file to write corrected reads to
    inputBinding:
      position: 3
  - id: begin_index
    type:
      - 'null'
      - int
    doc: index of read to start with
    inputBinding:
      position: 103
      prefix: --begin_index
  - id: branch_factor
    type:
      - 'null'
      - float
    doc: branching factor for correction, scaled by k
    inputBinding:
      position: 103
      prefix: --branch_factor
  - id: cache_size
    type:
      - 'null'
      - int
    doc: the length of k-mer to precompute in cache
    inputBinding:
      position: 103
      prefix: --cache_size
  - id: end_index
    type:
      - 'null'
      - int
    doc: index of read to end with
    inputBinding:
      position: 103
      prefix: --end_index
  - id: kmer_sizes
    type:
      - 'null'
      - type: array
        items: int
        inputBinding:
          prefix: -k
    doc: k-mer sizes for correction, can be specified multiple times (default 21 and 59)
    inputBinding:
      position: 103
  - id: min_count
    type:
      - 'null'
      - int
    doc: absolute minimum k-mer count to consisder a path
    inputBinding:
      position: 103
      prefix: --min_count
  - id: min_dynamic_count
    type:
      - 'null'
      - float
    doc: dynamic minimum k-mer count fraction of median to consider a path
    inputBinding:
      position: 103
      prefix: --min_dynamic_count
  - id: threads
    type:
      - 'null'
      - int
    doc: number of correction threads
    inputBinding:
      position: 103
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: enable verbose output
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: corrected_reads_file
    type: File
    doc: The FASTA file with corrected reads
    outputBinding:
      glob: $(inputs.corrected_reads_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fmlrc2:0.1.8--h7f95895_0
