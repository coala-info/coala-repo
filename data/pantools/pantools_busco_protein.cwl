cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - busco_protein
label: pantools_busco_protein
doc: "Identify BUSCO genes in the pangenome. Required software: BUSCO v3, v4 or v5.\n\
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
  - id: annotations_file
    type:
      - 'null'
      - File
    doc: A text file with the identifiers of annotations to be included, each on a
      separate line.
    inputBinding:
      position: 102
      prefix: --annotations-file=
      separate: false
  - id: busco_version
    type:
      - 'null'
      - int
    doc: 'The BUSCO version, 4 or 5 (default: 5).'
    inputBinding:
      position: 102
      prefix: --busco-version=
      separate: false
  - id: odb10
    type:
      - 'null'
      - string
    doc: An odb10 benchmark dataset name.
    inputBinding:
      position: 102
      prefix: --odb10=
      separate: false
  - id: longest
    type:
      - 'null'
      - boolean
    doc: Only search against the longest protein-coding transcript of genes.
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
  - id: all_automatic
    type:
      - 'null'
      - boolean
    doc: Run BUSCO for all genomes with automatic lineage selection.
    inputBinding:
      position: 102
      prefix: --all-automatic
  - id: skip_busco
    type:
      - 'null'
      - string
    doc: A list of questionable BUSCOs. The completeness score is recalculated by
      skipping these genes.
    inputBinding:
      position: 102
      prefix: --skip-busco=
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
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pantools:4.3.4--hdfd78af_0
stdout: pantools_busco_protein.log
