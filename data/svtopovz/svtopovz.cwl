cwlVersion: v1.2
class: CommandLineTool
baseCommand: svtopovz
label: svtopovz
doc: "Visualize structural variant calls from svtopo\n\nTool homepage: https://github.com/PacificBiosciences/HiFi-SVTopo"
inputs:
  - id: annotation_bed
    type:
      - 'null'
      - type: array
        items: File
    doc: space delimited list of one or more paths to genome annotations in BED 
      file format - optionally allows annotation title in column 4 and strand 
      (+/-) in column 5
    inputBinding:
      position: 101
      prefix: --annotation-bed
  - id: genes
    type:
      - 'null'
      - File
    doc: single path to gene annotations in GFF3 or GTF format (based on GENCODE
      v45 annotations)
    inputBinding:
      position: 101
      prefix: --genes
  - id: image_type
    type:
      - 'null'
      - string
    doc: type of image to generate
    inputBinding:
      position: 101
      prefix: --image-type
  - id: include_simple_breakpoints
    type:
      - 'null'
      - boolean
    doc: does not skip simple single-breakpoint events, such as deletions, 
      duplications, and nonreciprocal translocations
    inputBinding:
      position: 101
      prefix: --include-simple-breakpoints
  - id: max_gap_size_mb
    type:
      - 'null'
      - float
    doc: maximum gap size to show in one panel, in megabases.
    inputBinding:
      position: 101
      prefix: --max-gap-size-mb
  - id: svtopo_dir
    type: Directory
    doc: path to directory containing one or more svtopo output file pairs (in 
      json and bed format). GZIP allowed.
    inputBinding:
      position: 101
      prefix: --svtopo-dir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print verbose output for debugging purposes
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtopovz:0.3.0--pyhdfd78af_0
stdout: svtopovz.out
