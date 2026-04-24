cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - igvtools
  - count
label: igvtools_count
doc: "The count command computes alignment coverage of an alignment file. The output
  is a .tdf file, which can be loaded into IGV for viewing.\n\nTool homepage: http://www.broadinstitute.org/igv/"
inputs:
  - id: input_file
    type: File
    doc: 'Input file (supported formats: .bam, .sam, .alignment, .psl, .bed, .gff)'
    inputBinding:
      position: 1
  - id: genome
    type: string
    doc: Genome ID (e.g., hg19) or path to a .genome file
    inputBinding:
      position: 2
  - id: ext_factor
    type:
      - 'null'
      - int
    doc: The distance to extend each read
    inputBinding:
      position: 103
      prefix: --extFactor
  - id: functions
    type:
      - 'null'
      - string
    doc: Comma-separated list of window functions (min, max, mean, median, p2, 
      p10, p90, p98)
    inputBinding:
      position: 103
      prefix: --functions
  - id: include_duplicates
    type:
      - 'null'
      - boolean
    doc: Include duplicate reads in the coverage calculation
    inputBinding:
      position: 103
      prefix: --includeDuplicates
  - id: max_zoom
    type:
      - 'null'
      - int
    doc: The maximum zoom level to compute coverage for
    inputBinding:
      position: 103
      prefix: --maxZoom
  - id: min_map_quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality to include a read
    inputBinding:
      position: 103
      prefix: --minMapQuality
  - id: pairs
    type:
      - 'null'
      - boolean
    doc: Compute coverage using paired-end fragments
    inputBinding:
      position: 103
      prefix: --pairs
  - id: strands
    type:
      - 'null'
      - string
    doc: Compute coverage for strands separately (read, first, second)
    inputBinding:
      position: 103
      prefix: --strands
  - id: window_size
    type:
      - 'null'
      - int
    doc: The window size over which coverage is averaged
    inputBinding:
      position: 103
      prefix: --windowSize
outputs:
  - id: output_file
    type: File
    doc: Output file (must end in .tdf or .wig)
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igvtools:2.17.3--hdfd78af_0
