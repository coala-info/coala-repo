cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - group
label: pantools_group
doc: "Generate homology groups based on similarity of protein sequences. Required\
  \ software: MCL\n\nTool homepage: https://git.wur.nl/bioinformatics/pantools"
inputs:
  - id: database_directory
    type: Directory
    doc: Path to the database root directory. The database is staged writable (the
      tool changes it) and returned as the output.
    inputBinding:
      position: 1
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of parallel working threads, default is the number of cores or 8,
      whichever is lower.
    inputBinding:
      position: 102
      prefix: --threads=
      separate: false
  - id: selection_file
    type:
      - 'null'
      - File
    doc: Text file with rules to use a specific set of genomes and sequences. This
      automatically lowers the threshold for core genes.
    inputBinding:
      position: 102
      prefix: --selection-file=
      separate: false
  - id: include
    type:
      - 'null'
      - string
    doc: Only include a selection of genomes.
    inputBinding:
      position: 102
      prefix: --include=
      separate: false
  - id: exclude
    type:
      - 'null'
      - string
    doc: Exclude a selection of genomes.
    inputBinding:
      position: 102
      prefix: --exclude=
      separate: false
  - id: annotations_file
    type:
      - 'null'
      - File
    doc: A text file with the identifiers of annotations to be included.
    inputBinding:
      position: 102
      prefix: --annotations-file=
      separate: false
  - id: longest
    type:
      - 'null'
      - boolean
    doc: Only cluster protein sequences of the longest transcript per gene.
    inputBinding:
      position: 102
      prefix: --longest
  - id: scoring_matrix
    type:
      - 'null'
      - string
    doc: 'The scoring matrix used (default: BLOSUM62).'
    inputBinding:
      position: 102
      prefix: --scoring-matrix=
      separate: false
  - id: relaxation
    type:
      - 'null'
      - int
    doc: The relaxation in homology calls. Should be in range [1..8], from strict
      to relaxed. Use optimal_grouping to determine the best relaxation setting.
    inputBinding:
      position: 102
      prefix: --relaxation=
      separate: false
  - id: contrast
    type:
      - 'null'
      - float
    doc: The contrast factor. Should be in range [0,10].
    inputBinding:
      position: 102
      prefix: --contrast=
      separate: false
  - id: mcl_inflation
    type:
      - 'null'
      - float
    doc: The MCL inflation. Should be in range [1,19].
    inputBinding:
      position: 102
      prefix: --mcl-inflation=
      separate: false
  - id: intersection_rate
    type:
      - 'null'
      - float
    doc: The fraction of k-mers that needs to be shared by two intersecting proteins.
      Should be in range [0.001,0.1].
    inputBinding:
      position: 102
      prefix: --intersection-rate=
      separate: false
  - id: similarity_threshold
    type:
      - 'null'
      - int
    doc: The minimum normalized similarity score of two proteins. Should be in range
      [1..99].
    inputBinding:
      position: 102
      prefix: --similarity-threshold=
      separate: false
outputs:
  - id: database
    type: Directory
    doc: The updated pangenome database
    outputBinding:
      glob: $(inputs.database_directory.basename)
  - id: log
    type: stdout
    doc: Standard output (run log)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.database_directory)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
stdout: pantools_group.log
