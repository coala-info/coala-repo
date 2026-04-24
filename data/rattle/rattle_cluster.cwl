cwlVersion: v1.2
class: CommandLineTool
baseCommand: rattle_cluster
label: rattle_cluster
doc: "Rattlesnake clustering tool\n\nTool homepage: https://github.com/comprna/RATTLE"
inputs:
  - id: bv_end_threshold
    type:
      - 'null'
      - float
    doc: 'ending threshold for the bitvector k-mer comparison (default: 0.2)'
    inputBinding:
      position: 101
      prefix: --bv-end-threshold
  - id: bv_falloff
    type:
      - 'null'
      - float
    doc: 'falloff value for the bitvector threshold for each iteration (default: 0.05)'
    inputBinding:
      position: 101
      prefix: --bv-falloff
  - id: bv_start_threshold
    type:
      - 'null'
      - float
    doc: 'starting threshold for the bitvector k-mer comparison (default: 0.4)'
    inputBinding:
      position: 101
      prefix: --bv-start-threshold
  - id: input_file
    type: File
    doc: input fasta/fastq file (required)
    inputBinding:
      position: 101
      prefix: --input
  - id: iso
    type:
      - 'null'
      - boolean
    doc: perform clustering at the isoform level
    inputBinding:
      position: 101
      prefix: --iso
  - id: iso_kmer_size
    type:
      - 'null'
      - int
    doc: 'k-mer size for isoform clustering (default: 11, maximum: 16)'
    inputBinding:
      position: 101
      prefix: --iso-kmer-size
  - id: iso_max_variance
    type:
      - 'null'
      - int
    doc: 'max allowed variance for two reads to be in the same isoform cluster (default:
      25)'
    inputBinding:
      position: 101
      prefix: --iso-max-variance
  - id: iso_score_threshold
    type:
      - 'null'
      - float
    doc: 'minimum score for two reads to be in the same isoform cluster (default:
      0.3)'
    inputBinding:
      position: 101
      prefix: --iso-score-threshold
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: 'k-mer size for gene clustering (default: 10, maximum: 16)'
    inputBinding:
      position: 101
      prefix: --kmer-size
  - id: label
    type:
      - 'null'
      - type: array
        items: string
    doc: labels for the files in order of entry
    inputBinding:
      position: 101
      prefix: --label
  - id: lower_length
    type:
      - 'null'
      - int
    doc: 'set the lower length for input reads filter (default: 150)'
    inputBinding:
      position: 101
      prefix: --lower-length
  - id: max_variance
    type:
      - 'null'
      - int
    doc: 'max allowed variance for two reads to be in the same gene cluster (default:
      1000000)'
    inputBinding:
      position: 101
      prefix: --max-variance
  - id: min_reads_cluster
    type:
      - 'null'
      - int
    doc: 'minimum number of reads per cluster (default: 0)'
    inputBinding:
      position: 101
      prefix: --min-reads-cluster
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: 'output folder (default: .)'
    inputBinding:
      position: 101
      prefix: --output
  - id: raw
    type:
      - 'null'
      - boolean
    doc: use this flag if want to use raw datasets
    inputBinding:
      position: 101
      prefix: --raw
  - id: repr_percentile
    type:
      - 'null'
      - float
    doc: 'cluster representative percentile (default: 0.15)'
    inputBinding:
      position: 101
      prefix: --repr-percentile
  - id: rna
    type:
      - 'null'
      - boolean
    doc: use this mode if data is direct RNA (disables checking both strands)
    inputBinding:
      position: 101
      prefix: --rna
  - id: score_threshold
    type:
      - 'null'
      - float
    doc: 'minimum score for two reads to be in the same gene cluster (default: 0.2)'
    inputBinding:
      position: 101
      prefix: --score-threshold
  - id: threads
    type:
      - 'null'
      - int
    doc: 'number of threads to use (default: 1)'
    inputBinding:
      position: 101
      prefix: --threads
  - id: upper_length
    type:
      - 'null'
      - int
    doc: 'set the upper length for input reads filter (default: 100,000)'
    inputBinding:
      position: 101
      prefix: --upper-length
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: use this flag if need to print the progress
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rattle:1.0--h5ca1c30_0
stdout: rattle_cluster.out
