cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - repeat_overview
label: pantools_repeat_overview
doc: "Generates metrics about the repeat sequences in the pangenome\n\nTool homepage:\
  \ https://git.wur.nl/bioinformatics/pantools"
inputs:
  - id: database_directory
    type: Directory
    doc: Path to the database root directory. The database is staged writable (the
      tool writes its results inside it) and returned as the output.
    inputBinding:
      position: 1
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
  - id: exclude_repeats
    type:
      - 'null'
      - File
    doc: A text file with repeat types to exclude from the analysis (the help gives
      no description).
    inputBinding:
      position: 102
      prefix: --exclude-repeats=
      separate: false
  - id: window_length
    type:
      - 'null'
      - int
    doc: Length of the sliding window for repeat coverage and density (the help gives
      no description).
    inputBinding:
      position: 102
      prefix: --window-length=
      separate: false
  - id: upstream
    type:
      - 'null'
      - int
    doc: Length of the upstream region of genes that is checked for repeats (default
      1000; the help gives no description).
    inputBinding:
      position: 102
      prefix: --upstream=
      separate: false
  - id: downstream
    type:
      - 'null'
      - int
    doc: Length of the downstream region of genes that is checked for repeats (default
      1000; the help gives no description).
    inputBinding:
      position: 102
      prefix: --downstream=
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
stdout: pantools_repeat_overview.log
