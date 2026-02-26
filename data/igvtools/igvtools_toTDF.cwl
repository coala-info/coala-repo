cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - igvtools
  - toTDF
label: igvtools_toTDF
doc: "The toTDF command converts a sorted data file to a binary tiled data file (TDF).
  Supported input formats are: .wig, .bed, .gff, .map, .psl, .sam, and .bam.\n\nTool
  homepage: http://www.broadinstitute.org/igv/"
inputs:
  - id: input_file
    type: File
    doc: Input file (wig, bed, gff, map, psl, sam, or bam)
    inputBinding:
      position: 1
  - id: genome
    type: string
    doc: Genome ID (e.g., hg19, mm10) or path to a .chrom.sizes or .genome file
    inputBinding:
      position: 2
  - id: extension
    type:
      - 'null'
      - int
    doc: The distance (in bp) to extend each feature
    inputBinding:
      position: 103
      prefix: -e
  - id: window_functions
    type:
      - 'null'
      - string
    doc: Comma-separated list of window functions (mean, max, min, etc.)
    inputBinding:
      position: 103
      prefix: -f
  - id: window_size
    type:
      - 'null'
      - int
    doc: The window size over which data are averaged
    inputBinding:
      position: 103
      prefix: -w
  - id: zoom_levels
    type:
      - 'null'
      - int
    doc: Maximum zoom level to precompute
    inputBinding:
      position: 103
      prefix: -z
outputs:
  - id: output_file
    type: File
    doc: Output file (must end in .tdf)
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igvtools:2.17.3--hdfd78af_0
