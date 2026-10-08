cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - synteny_overview
label: pantools_synteny_overview
doc: "Generates metrics about the synteny blocks in the pangenome\n\nTool homepage:\
  \ https://git.wur.nl/bioinformatics/pantools"
inputs:
  - id: database_directory
    type: Directory
    doc: Path to the database root directory. The database is staged writable (the
      tool writes its results inside it) and returned as the output.
    inputBinding:
      position: 1
  - id: collinearity_file
    type: File
    doc: A MCScanX .collinearity file (for example synteny/mcscanx.collinearity in
      the database).
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: synteny_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Files that the tool reads from the same folder as the collinearity file:
      mcscanx.homology (required by the tool), and optionally mcscanx.gff and synteny_identifiers.csv.
      They are staged in the working directory next to the collinearity file.'
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
      - entry: $(inputs.collinearity_file)
        writable: true
      - $(inputs.synteny_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
stdout: pantools_synteny_overview.log
