cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kcftools
  - getVariations
label: kcftools_getVariations
doc: "Screen for reference kmers that are not present in the KMC database, and detect
  variation\n\nTool homepage: https://github.com/sivasubramanics/kcftools"
inputs:
  - id: feature
    type: string
    doc: Feature type ("window" or "gene" or "transcript")
    inputBinding:
      position: 101
      prefix: --feature
  - id: gtf
    type:
      - 'null'
      - File
    doc: GTF file name
    inputBinding:
      position: 101
      prefix: --gtf
  - id: inner_distance_weight
    type:
      - 'null'
      - float
    doc: Inner kmer distance weight
    inputBinding:
      position: 101
      prefix: --wi
  - id: kmc
    type: File
    doc: KMC database (<prefix>.kmc_pre); the <prefix>.kmc_suf file must sit beside it
    secondaryFiles:
      - ^.kmc_suf
    inputBinding:
      position: 101
      prefix: --kmc
      valueFrom: $(self.path.replace(/\.kmc_pre$/, ''))
  - id: kmer_ratio_weight
    type:
      - 'null'
      - float
    doc: Kmer ratio weight
    inputBinding:
      position: 101
      prefix: --wr
  - id: memory
    type:
      - 'null'
      - boolean
    doc: Load KMC database into memory
    inputBinding:
      position: 101
      prefix: --memory
  - id: min_k_count
    type:
      - 'null'
      - int
    doc: Minimum kmer count to consider
    inputBinding:
      position: 101
      prefix: --min-k-count
  - id: reference
    type: File
    doc: Reference file name
    inputBinding:
      position: 101
      prefix: --reference
      valueFrom: $(self.basename)
  - id: sample
    type: string
    doc: Sample name
    inputBinding:
      position: 101
      prefix: --sample
  - id: step
    type:
      - 'null'
      - int
    doc: Step size for sliding window [window size]
    inputBinding:
      position: 101
      prefix: --step
  - id: tail_distance_weight
    type:
      - 'null'
      - float
    doc: Tail kmer distance weight
    inputBinding:
      position: 101
      prefix: --wt
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: window
    type:
      - 'null'
      - int
    doc: Window size
    inputBinding:
      position: 101
      prefix: --window
  - id: output_path
    type: string
    doc: Output file name
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.reference)
        writable: true
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kcftools:0.4.0--hdfd78af_0
