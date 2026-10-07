cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwtk
  - bg2bw
label: bwtk_bg2bw
doc: "Convert a bedGraph file to bigWig. Order of operations: a -> m -> l -> t -> s\n\nTool homepage: https://github.com/bjmt/bwtk"
inputs:
  - id: input_bedgraph
    type: File
    doc: Input bedGraph (can be gzipped)
    inputBinding:
      position: 1
      prefix: -i
  - id: output_bigwig
    type: string
    doc: Output bigWig
    inputBinding:
      position: 1
      prefix: -o
  - id: chrom_sizes
    type:
      - 'null'
      - File
    doc: Genome chrom.sizes or genome.fa.fai file
    inputBinding:
      position: 1
      prefix: -g
  - id: preset_genome
    type:
      - 'null'
      - string
    doc: Use a preset genome instead of -g [tair10]
    inputBinding:
      position: 1
      prefix: -p
  - id: ucsc_names
    type:
      - 'null'
      - boolean
    doc: 'When using -p, use UCSC-style names (default: Ensembl)'
    inputBinding:
      position: 1
      prefix: -u
  - id: skip_missing_chroms
    type:
      - 'null'
      - boolean
    doc: Ignore chromosomes found in bedGraph but not chrom.sizes
    inputBinding:
      position: 1
      prefix: -S
  - id: add_value
    type:
      - 'null'
      - float
    doc: Add this value to scores [0]
    inputBinding:
      position: 1
      prefix: -a
  - id: multiply_value
    type:
      - 'null'
      - float
    doc: Multiply scores by this value [1]
    inputBinding:
      position: 1
      prefix: -m
  - id: log10_transform
    type:
      - 'null'
      - boolean
    doc: log10-transform scores
    inputBinding:
      position: 1
      prefix: -l
  - id: trim_max
    type:
      - 'null'
      - float
    doc: Trim values above this max [Inf]
    inputBinding:
      position: 1
      prefix: -t
  - id: step_size
    type:
      - 'null'
      - int
    doc: Step size for binning [0]
    inputBinding:
      position: 1
      prefix: -s
outputs:
  - id: bigwig
    type: File
    doc: Output bigWig file
    outputBinding:
      glob: $(inputs.output_bigwig)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwtk:1.8.1--h9990f68_0
