cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - pangenome_structure
label: pantools_pangenome_structure
doc: "Determine the openness of the pangenome based on homology groups or k-mer sequences.\n\
  \nTool homepage: https://git.wur.nl/bioinformatics/pantools"
inputs:
  - id: database_directory
    type: Directory
    doc: Path to the database root directory. The database is staged writable (the
      tool writes its results inside it) and returned as the output.
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
  - id: exclude
    type:
      - 'null'
      - string
    doc: Exclude a selection of genomes (for example 3,4).
    inputBinding:
      position: 102
      prefix: --exclude=
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
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for the random number generator.
    inputBinding:
      position: 102
      prefix: --seed=
      separate: false
  - id: kmer
    type:
      - 'null'
      - boolean
    doc: Pangenome size estimation based on k-mer sequences.
    inputBinding:
      position: 102
      prefix: --kmer
  - id: pavs
    type:
      - 'null'
      - boolean
    doc: Use included variation (PAV information).
    inputBinding:
      position: 102
      prefix: --pavs
  - id: loops
    type:
      - 'null'
      - int
    doc: Number of loops (default 100 for kmers, 10000 for genes).
    inputBinding:
      position: 102
      prefix: --loops=
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
stdout: pantools_pangenome_structure.log
