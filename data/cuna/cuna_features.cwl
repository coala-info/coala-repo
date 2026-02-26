cwlVersion: v1.2
class: CommandLineTool
baseCommand: cuna_features
label: cuna_features
doc: "Extracts features from sequencing data.\n\nTool homepage: https://github.com/iris1901/CUNA"
inputs:
  - id: bam
    type: File
    doc: Path to BAM file with move table
    inputBinding:
      position: 101
      prefix: --bam
  - id: chrom
    type:
      - 'null'
      - type: array
        items: string
    doc: List of contigs to include (optional)
    inputBinding:
      position: 101
      prefix: --chrom
  - id: div_threshold
    type:
      - 'null'
      - float
    doc: Divergence Threshold.
    default: 0.25
    inputBinding:
      position: 101
      prefix: --div_threshold
  - id: file_type
    type:
      - 'null'
      - string
    doc: Signal file format
    default: pod5
    inputBinding:
      position: 101
      prefix: --file_type
  - id: input
    type: Directory
    doc: Path to folder containing POD5 files
    inputBinding:
      position: 101
      prefix: --input
  - id: length_cutoff
    type:
      - 'null'
      - int
    doc: Minimum read length
    default: 0
    inputBinding:
      position: 101
      prefix: --length_cutoff
  - id: norm_type
    type:
      - 'null'
      - string
    doc: Normalization method
    default: mad
    inputBinding:
      position: 101
      prefix: --norm_type
  - id: pos_list
    type: File
    doc: File with positions and labels (chrom pos strand label)
    inputBinding:
      position: 101
      prefix: --pos_list
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for the output files
    default: output
    inputBinding:
      position: 101
      prefix: --prefix
  - id: reads_per_chunk
    type:
      - 'null'
      - int
    doc: Reads per chunk
    default: 100000
    inputBinding:
      position: 101
      prefix: --reads_per_chunk
  - id: ref
    type: File
    doc: Path to reference FASTA file
    inputBinding:
      position: 101
      prefix: --ref
  - id: seq_type
    type:
      - 'null'
      - string
    doc: Specify DNA sequencing only
    default: dna
    inputBinding:
      position: 101
      prefix: --seq_type
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of processors to use
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: window
    type:
      - 'null'
      - int
    doc: Number of bases before or after the base of interest to include in the 
      model. Total will be 2xwindow+1.
    default: 10
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: output
    type: Directory
    doc: Path to folder where features will be stored
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cuna:0.3.0--pyhdfd78af_0
