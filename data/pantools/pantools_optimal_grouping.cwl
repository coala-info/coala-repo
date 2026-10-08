cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - optimal_grouping
label: pantools_optimal_grouping
doc: "Find the most suitable settings for group.\n\nTool homepage: https://git.wur.nl/bioinformatics/pantools"
inputs:
  - id: database_directory
    type: Directory
    doc: Path to the database root directory. The database is staged writable (the
      tool writes its results inside it) and returned as the output.
    inputBinding:
      position: 1
  - id: busco_directory
    type: Directory
    doc: The output directory created by the BuscoProtein function. This directory
      is found inside the pangenome database, in the busco directory.
    inputBinding:
      position: 2
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
    doc: Only include a selection of genomes (for example 1,2).
    inputBinding:
      position: 102
      prefix: --include=
      separate: false
  - id: exclude
    type:
      - 'null'
      - string
    doc: Exclude a selection of genomes (for example 3,4).
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
  - id: fast
    type:
      - 'null'
      - boolean
    doc: Assume the optimal grouping is found when the F1-score drops compared to
      the previous clustering round.
    inputBinding:
      position: 102
      prefix: --fast
  - id: longest
    type:
      - 'null'
      - boolean
    doc: Only cluster protein sequences of the longest transcript per gene.
    inputBinding:
      position: 102
      prefix: --longest
  - id: phasing
    type:
      - 'null'
      - boolean
    doc: Analyse phased genomes.
    inputBinding:
      position: 102
      prefix: --phasing
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
    doc: Only consider a selection of relaxation settings (1-8 allowed).
    inputBinding:
      position: 102
      prefix: --relaxation=
      separate: false
outputs:
  - id: database
    type: Directory
    doc: The pangenome database, with the results written inside it.
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
stdout: pantools_optimal_grouping.log
