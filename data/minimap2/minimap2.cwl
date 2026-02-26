cwlVersion: v1.2
class: CommandLineTool
baseCommand: minimap2
label: minimap2
doc: "A versatile pairwise aligner for genomic and spliced nucleotide sequences\n\n\
  Tool homepage: https://github.com/lh3/minimap2"
inputs:
  - id: target
    type: File
    doc: Target sequence file (FASTA/FASTQ/mmi index)
    inputBinding:
      position: 1
  - id: query
    type:
      type: array
      items: File
    doc: Query sequence file(s) (FASTA/FASTQ)
    inputBinding:
      position: 2
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: K-mer size (no larger than 28)
    inputBinding:
      position: 103
      prefix: -k
  - id: min_chain_score
    type:
      - 'null'
      - int
    doc: Minimal chaining score
    inputBinding:
      position: 103
      prefix: -m
  - id: output_sam
    type:
      - 'null'
      - boolean
    doc: Output in SAM format (default is PAF)
    inputBinding:
      position: 103
      prefix: -a
  - id: preset
    type:
      - 'null'
      - string
    doc: Preset (e.g. map-pb, map-ont, asm5, asm10, asm20, sr, splice)
    inputBinding:
      position: 103
      prefix: -x
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 3
    inputBinding:
      position: 103
      prefix: -t
  - id: window_size
    type:
      - 'null'
      - int
    doc: Minimizer window size
    inputBinding:
      position: 103
      prefix: -w
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minimap2:2.30--h577a1d6_0
