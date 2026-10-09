cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - igvtools
  - count
label: igvtools_count
doc: "Compute average feature density (coverage) over a window across the genome for an alignment or bed file. Output is a .tdf and/or .wig file.\n\nTool homepage: http://www.broadinstitute.org/igv/"
inputs:
  - id: input_file
    type: File
    doc: "Input file (.sam, .bam, .aligned, .sorted.txt, .bed or .bam.list); must be sorted by start position"
    inputBinding:
      position: 10
  - id: output_name
    type: string
    doc: "Output file name: .tdf, .wig, or both separated by a comma (outputBinary.tdf,outputText.wig)"
    inputBinding:
      position: 11
  - id: genome
    type: [File, string]
    doc: "Genome id or path to a chrom.sizes, .genome or genome json file (a FASTA file also works)"
    secondaryFiles:
      - pattern: .fai
        required: false
    inputBinding:
      position: 12
  - id: max_zoom
    type: ['null', int]
    doc: "Maximum zoom level to precompute"
    inputBinding:
      position: 1
      prefix: --maxZoom
  - id: window_size
    type: ['null', int]
    doc: "Window size over which coverage is averaged (default 25 bp)"
    inputBinding:
      position: 1
      prefix: --windowSize
  - id: ext_factor
    type: ['null', int]
    doc: "Extend the read or feature by this distance (bp) before counting"
    inputBinding:
      position: 1
      prefix: --extFactor
  - id: pre_ext_factor
    type: ['null', int]
    doc: "Extend the read upstream from the 5' end by this distance"
    inputBinding:
      position: 1
      prefix: --preExtFactor
  - id: post_ext_factor
    type: ['null', int]
    doc: "Downstream extent from the 5' end (overrides read length)"
    inputBinding:
      position: 1
      prefix: --postExtFactor
  - id: window_functions
    type: ['null', string]
    doc: "Comma delimited window functions: min, max, mean, median, p2, p10, p90, p98"
    inputBinding:
      position: 1
      prefix: --windowFunctions
  - id: strands
    type: ['null', string]
    doc: "Count each strand separately: read or first"
    inputBinding:
      position: 1
      prefix: --strands
  - id: query
    type: ['null', string]
    doc: "Only count a region, chr:start-end (input must be indexed)"
    inputBinding:
      position: 1
      prefix: --query
  - id: min_map_quality
    type: ['null', int]
    doc: "Minimum mapping quality of reads to include (default 0)"
    inputBinding:
      position: 1
      prefix: --minMapQuality
  - id: bases
    type: ['null', boolean]
    doc: "Count the occurrence of each base (A,G,C,T,N)"
    inputBinding:
      position: 1
      prefix: --bases
  - id: include_duplicates
    type: ['null', boolean]
    doc: "Include duplicate alignments in count"
    inputBinding:
      position: 1
      prefix: --includeDuplicates
  - id: pairs
    type: ['null', boolean]
    doc: "Compute coverage from paired alignments counting the entire insert as covered (proper pairs only)"
    inputBinding:
      position: 1
      prefix: --pairs
outputs:
  - id: output_file
    type: File[]
    doc: "Coverage output (.tdf or .wig)"
    outputBinding:
      glob: $(inputs.output_name.split(','))
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igvtools:2.17.3--hdfd78af_0
