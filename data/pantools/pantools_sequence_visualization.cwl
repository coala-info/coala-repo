cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - sequence_visualization
label: pantools_sequence_visualization
doc: "Generate a visualization of multiple sequences with the possibility of different\
  \ types of annotation bars.\n\nTool homepage: https://git.wur.nl/bioinformatics/pantools"
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
  - id: rules
    type:
      - 'null'
      - File
    doc: Text file with rules that set the bar types and the sequences (in order)
      to visualize, for example the lines "sequence 1_1,2_1" and "gene_coverage".
    inputBinding:
      position: 102
      prefix: --rules=
      separate: false
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size of the sliding window for gene and repeat coverage (the tool
      requires at least 10000).
    inputBinding:
      position: 102
      prefix: --window-size=
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
stdout: pantools_sequence_visualization.log
