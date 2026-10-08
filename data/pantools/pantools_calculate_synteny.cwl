cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - calculate_synteny
label: pantools_calculate_synteny
doc: "Calculate synteny between sequences with MCScanX. Required software: MCScanX.\n\
  \nTool homepage: https://git.wur.nl/bioinformatics/pantools"
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
  - id: homology_file
    type:
      - 'null'
      - File
    doc: A text file with homology group node identifiers, separated by a comma.
    inputBinding:
      position: 102
      prefix: --homology-file=
      separate: false
  - id: homology_groups
    type:
      - 'null'
      - string
    doc: A list of homology group node identifiers, separated by a comma.
    inputBinding:
      position: 102
      prefix: --homology-groups=
      separate: false
  - id: run
    type:
      - 'null'
      - boolean
    doc: Perform MCScanX.
    inputBinding:
      position: 102
      prefix: --run
  - id: longest
    type:
      - 'null'
      - boolean
    doc: Only cluster protein sequences of the longest transcript per gene.
    inputBinding:
      position: 102
      prefix: --longest
  - id: sequence
    type:
      - 'null'
      - boolean
    doc: Perform the analysis on a sequence level in addition to the genome.
    inputBinding:
      position: 102
      prefix: --sequence
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
stdout: pantools_calculate_synteny.log
