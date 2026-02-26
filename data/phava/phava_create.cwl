cwlVersion: v1.2
class: CommandLineTool
baseCommand: phava create
label: phava_create
doc: "Create PhaVa data structures\n\nTool homepage: https://github.com/patrickwest/PhaVa"
inputs:
  - id: dir
    type: Directory
    doc: Directory where data and output are stored *** USE THE SAME WORK 
      DIRECTORY FOR ALL PHAVA OPERATIONS ***
    inputBinding:
      position: 101
      prefix: --dir
  - id: fasta
    type:
      - 'null'
      - File
    doc: Name of input assembly file to be searched
    default: None
    inputBinding:
      position: 101
      prefix: --fasta
  - id: flank_size
    type:
      - 'null'
      - int
    doc: Size flanking size to include on either side of invertable regions (in 
      bps)
    default: 1000
    inputBinding:
      position: 101
      prefix: --flankSize
  - id: genes
    type:
      - 'null'
      - string
    doc: List of gene features in ncbi genbank format, for detecting 
      gene/inverton overlaps
    default: None
    inputBinding:
      position: 101
      prefix: --genes
  - id: genes_format
    type:
      - 'null'
      - string
    doc: File format of the list of gene features. Gff must be in prodigal gff 
      format
    default: gbff
    inputBinding:
      position: 101
      prefix: --genesFormat
  - id: irs
    type:
      - 'null'
      - string
    doc: Table of identified invertable repeats (eg. if locate command was never
      run)
    default: None
    inputBinding:
      position: 101
      prefix: --irs
  - id: log
    type:
      - 'null'
      - boolean
    doc: Should the logging info be output to stdout? Otherwise, it will be 
      written to 'PhaVa.log'
    inputBinding:
      position: 101
      prefix: --log
  - id: mock_genome
    type:
      - 'null'
      - boolean
    doc: Create a mock genome where all putative IRs are flipped to opposite of 
      the reference orientation
    default: false
    inputBinding:
      position: 101
      prefix: --mockGenome
  - id: mock_number
    type:
      - 'null'
      - int
    doc: If creating a mockGenome, the number of invertons to invert. A value of
      0 inverts all predicted inverton locations
    default: 0
    inputBinding:
      position: 101
      prefix: --mockNumber
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 101
      prefix: --cpus
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phava:0.2.3--pyhdfd78af_0
stdout: phava_create.out
