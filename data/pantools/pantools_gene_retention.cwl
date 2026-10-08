cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - gene_retention
label: pantools_gene_retention
doc: "Visualize gene retention of sequences to a selected query sequence\n\nTool homepage:\
  \ https://git.wur.nl/bioinformatics/pantools"
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
  - id: input_sequences
    type:
      - 'null'
      - File
    doc: Text file with sequences (identifiers) to be be used as reference. Identifiers
      must be placed on a single line separated by commas. Default is all sequences.
    inputBinding:
      position: 102
      prefix: --input-sequences=
      separate: false
  - id: window_length
    type:
      - 'null'
      - int
    doc: Set the sliding window length. Default is 100 (genes).
    inputBinding:
      position: 102
      prefix: --window-length=
      separate: false
  - id: sequences_plot
    type:
      - 'null'
      - int
    doc: Set the maximum number of sequences per (combination) plot. Default is 20.
    inputBinding:
      position: 102
      prefix: --sequences-plot=
      separate: false
  - id: sequences_genome
    type:
      - 'null'
      - int
    doc: Set the maximum number of sequences per genome plot. Default is 20.
    inputBinding:
      position: 102
      prefix: --sequences-genome=
      separate: false
  - id: coloring
    type:
      - 'null'
      - string
    doc: 'Use the most distinctive colors (distinctive) or phasing information (phasing)
      to color plots (default: distinct).'
    inputBinding:
      position: 102
      prefix: --coloring=
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
stdout: pantools_gene_retention.log
