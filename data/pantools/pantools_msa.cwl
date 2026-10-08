cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - msa
label: pantools_msa
doc: "Create multiple sequence alignments. By default, only nucleotide sequences are\
  \ aligned for pangenome databases and only protein sequences are aligned for panproteome\
  \ databases. If variants were added to a pangenome, these will be aligned by default.\
  \ Required software: MAFFT, FastTree.\n\nTool homepage: https://git.wur.nl/bioinformatics/pantools"
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
    doc: 'Number of threads for MAFFT (highly recommended! default: 8).'
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
    doc: A list of homology group node identifiers, separated by a comma. Default
      is all homology groups.
    inputBinding:
      position: 102
      prefix: --homology-groups=
      separate: false
  - id: regions_file
    type:
      - 'null'
      - File
    doc: 'A text file containing genome locations with on each line: a genome number,
      sequence number, begin and end position, separated by a space.'
    inputBinding:
      position: 102
      prefix: --regions-file=
      separate: false
  - id: method
    type:
      - 'null'
      - string
    doc: The kind of alignment to make. Can be either per-group, multiple-groups,
      regions or functions.
    inputBinding:
      position: 102
      prefix: --method=
      separate: false
  - id: align_nucleotide
    type:
      - 'null'
      - boolean
    doc: Align nucleotide sequences.
    inputBinding:
      position: 102
      prefix: --align-nucleotide
  - id: align_protein
    type:
      - 'null'
      - boolean
    doc: Align protein sequences.
    inputBinding:
      position: 102
      prefix: --align-protein
  - id: align_variants
    type:
      - 'null'
      - boolean
    doc: Align variants (if variants were added to the pangenome).
    inputBinding:
      position: 102
      prefix: --align-variants
  - id: pavs
    type:
      - 'null'
      - boolean
    doc: Skip variant nodes if they are absent (PAV information).
    inputBinding:
      position: 102
      prefix: --pavs
  - id: phenotype
    type:
      - 'null'
      - boolean
    doc: Identify phenotype shared/specific/exclusive positions in alignments.
    inputBinding:
      position: 102
      prefix: --phenotype
  - id: blosum
    type:
      - 'null'
      - int
    doc: 'A BLOSUM matrix to be used for the calculation of protein similarity. Allowed
      values are 45, 50, 62 80 and 90 (default: 62).'
    inputBinding:
      position: 102
      prefix: --blosum=
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
  - id: trimming
    type:
      - 'null'
      - boolean
    doc: 'Align the sequences only once (default: true).'
    inputBinding:
      position: 102
      prefix: --trimming
  - id: no_trimming
    type:
      - 'null'
      - boolean
    doc: Do not align the sequences only once; negation of --trimming.
    inputBinding:
      position: 102
      prefix: --no-trimming
  - id: fasttree
    type:
      - 'null'
      - boolean
    doc: 'Run FastTree (default: true).'
    inputBinding:
      position: 102
      prefix: --fasttree
  - id: no_fasttree
    type:
      - 'null'
      - boolean
    doc: Do not run FastTree; negation of --fasttree.
    inputBinding:
      position: 102
      prefix: --no-fasttree
  - id: trim_using_proteins
    type:
      - 'null'
      - boolean
    doc: 'Trim nucleotide sequences using the protein sequences (default: false).'
    inputBinding:
      position: 102
      prefix: --trim-using-proteins
  - id: functions
    type:
      - 'null'
      - string
    doc: For specifying one or multiple functional domains (Only used when --method=functions).
    inputBinding:
      position: 102
      prefix: --functions=
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
stdout: pantools_msa.log
