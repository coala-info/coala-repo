cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - locate_genes
label: pantools_locate_genes
doc: "Identify and compare gene clusters of from a set of homology groups.\n\nTool\
  \ homepage: https://git.wur.nl/bioinformatics/pantools"
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
  - id: phenotype
    type:
      - 'null'
      - string
    doc: A phenotype name, used to identify gene clusters shared by all phenotype
      members.
    inputBinding:
      position: 102
      prefix: --phenotype=
      separate: false
  - id: nucleotides
    type:
      - 'null'
      - int
    doc: The number of allowed nucleotides between two neighbouring genes (default
      is 1 MB).
    inputBinding:
      position: 102
      prefix: --nucleotides=
      separate: false
  - id: gap_open
    type:
      - 'null'
      - int
    doc: 'When constructing the clusters, allow a number of genes for each cluster
      that are not originally part of the input groups (default: 0).'
    inputBinding:
      position: 102
      prefix: --gap-open=
      separate: false
  - id: core_threshold
    type:
      - 'null'
      - int
    doc: Lower the threshold (%) for a group to be considered (soft) core (default
      is the total number of genomes found in the groups, not a percentage).
    inputBinding:
      position: 102
      prefix: --core-threshold=
      separate: false
  - id: ignore_duplications
    type:
      - 'null'
      - boolean
    doc: Duplicated and co-localized genes no longer break up clusters.
    inputBinding:
      position: 102
      prefix: --ignore-duplications
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
stdout: pantools_locate_genes.log
