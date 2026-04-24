cwlVersion: v1.2
class: CommandLineTool
baseCommand: biox
label: biox
doc: "BioX: A tool for biological sequence compression and analysis\n\nTool homepage:
  https://github.com/TianMayCry9/BioX"
inputs:
  - id: alpha
    type:
      - 'null'
      - float
    doc: Distance correction coefficient (0-1)
    inputBinding:
      position: 101
      prefix: --alpha
  - id: analysis
    type:
      - 'null'
      - boolean
    doc: Sequence analysis mode
    inputBinding:
      position: 101
      prefix: --analysis
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Compress mode
    inputBinding:
      position: 101
      prefix: --compress
  - id: confidence
    type:
      - 'null'
      - float
    doc: Confidence threshold for classification
    inputBinding:
      position: 101
      prefix: --confidence
  - id: decompress
    type:
      - 'null'
      - boolean
    doc: Decompress mode
    inputBinding:
      position: 101
      prefix: --decompress
  - id: input
    type: File
    doc: Input file/directory path
    inputBinding:
      position: 101
      prefix: --input
  - id: jobs
    type:
      - 'null'
      - int
    doc: Number of parallel jobs
    inputBinding:
      position: 101
      prefix: --jobs
  - id: level
    type:
      - 'null'
      - int
    doc: 'Compression level (1-9, default: 3)'
    inputBinding:
      position: 101
      prefix: --level
  - id: method
    type:
      - 'null'
      - string
    doc: Distance calculation method
    inputBinding:
      position: 101
      prefix: --method
  - id: neighbors
    type:
      - 'null'
      - int
    doc: Number of neighbors for KNN classification
    inputBinding:
      position: 101
      prefix: --neighbors
  - id: num_processes
    type:
      - 'null'
      - int
    doc: Number of parallel processes
    inputBinding:
      position: 101
      prefix: --num_processes
  - id: plant
    type:
      - 'null'
      - boolean
    doc: Use plant genome compression scheme
    inputBinding:
      position: 101
      prefix: --plant
  - id: plus_line
    type:
      - 'null'
      - string
    doc: FASTQ plus line handling
    inputBinding:
      position: 101
      prefix: --plus_line
  - id: split
    type:
      - 'null'
      - int
    doc: Split output into N volumes (2-10)
    inputBinding:
      position: 101
      prefix: --split
  - id: taxonomy_level
    type:
      - 'null'
      - string
    doc: NCBI taxonomy level for classification
    inputBinding:
      position: 101
      prefix: --taxonomy-level
  - id: tree
    type:
      - 'null'
      - string
    doc: Method for phylogenetic tree construction
    inputBinding:
      position: 101
      prefix: --tree
  - id: type
    type:
      - 'null'
      - string
    doc: Sequence type (dna/rna/protein) or regular file
    inputBinding:
      position: 101
      prefix: --type
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file/directory path
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biox:1.2.0--pyhdfd78af_0
