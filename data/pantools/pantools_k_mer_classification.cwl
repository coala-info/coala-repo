cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - k_mer_classification
label: pantools_k_mer_classification
doc: "Calculate the number of core, accessory, unique, (and phenotype specific) k-mer\
  \ sequences.\n\nTool homepage: https://git.wur.nl/bioinformatics/pantools"
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
  - id: phenotype
    type:
      - 'null'
      - string
    doc: Name of the phenotype.
    inputBinding:
      position: 102
      prefix: --phenotype=
      separate: false
  - id: compressed
    type:
      - 'null'
      - boolean
    doc: Do not uncompress collapsed non-branching k-mers for k-mer counting.
    inputBinding:
      position: 102
      prefix: --compressed
  - id: core_threshold
    type:
      - 'null'
      - int
    doc: Threshold (%) for (soft) core genes. Default is 100% of genomes.
    inputBinding:
      position: 102
      prefix: --core-threshold=
      separate: false
  - id: unique_threshold
    type:
      - 'null'
      - int
    doc: Threshold (%) for unique/cloud genes. Default is a single genome, not a percentage.
    inputBinding:
      position: 102
      prefix: --unique-threshold=
      separate: false
  - id: phenotype_threshold
    type:
      - 'null'
      - int
    doc: Threshold (%) for phenotype specific/shared genes. Default is 100% of genomes
      with phenotype.
    inputBinding:
      position: 102
      prefix: --phenotype-threshold=
      separate: false
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
  - id: phasing
    type:
      - 'null'
      - boolean
    doc: Analyse phased genomes.
    inputBinding:
      position: 102
      prefix: --phasing
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
stdout: pantools_k_mer_classification.log
