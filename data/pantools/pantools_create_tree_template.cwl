cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - create_tree_template
label: pantools_create_tree_template
doc: "Create templates for coloring phylogenetic trees in iTOL.\n\nTool homepage:\
  \ https://git.wur.nl/bioinformatics/pantools"
inputs:
  - id: database_directory
    type: Directory
    doc: Path to the database root directory. The database is staged writable (the
      tool changes it) and returned as the output.
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
  - id: color
    type:
      - 'null'
      - int
    doc: 'Assign a color to a phenotypes with a minimum amount of genomes (default:
      2).'
    inputBinding:
      position: 102
      prefix: --color=
      separate: false
  - id: phenotype
    type:
      - 'null'
      - string
    doc: Use the names from this phenotype.
    inputBinding:
      position: 102
      prefix: --phenotype=
      separate: false
  - id: no_numbers
    type:
      - 'null'
      - boolean
    doc: Do not add numbers to the names.
    inputBinding:
      position: 102
      prefix: --no-numbers
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
  - id: genome
    type:
      - 'null'
      - boolean
    doc: Only perform the analysis between genomes.
    inputBinding:
      position: 102
      prefix: --genome
  - id: gene_tree
    type:
      - 'null'
      - string
    doc: Create the template for this gene tree.
    inputBinding:
      position: 102
      prefix: --gene-tree=
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
stdout: pantools_create_tree_template.log
