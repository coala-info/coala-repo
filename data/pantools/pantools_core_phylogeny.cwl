cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pantools
  - core_phylogeny
label: pantools_core_phylogeny
doc: "Create a SNP tree from single-copy genes. By default, only nucleotide sequences\
  \ are aligned for pangenome databases and only protein sequences are aligned for\
  \ panproteome databases. If variants are present in the pangenome, these will be\
  \ used as well. Required software: MAFFT, IQ-tree (Only required for Maximum-Likelihood).\n\
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
  - id: homology_file
    type:
      - 'null'
      - File
    doc: A file with homology group node identifiers of single copy groups. Default
      is single_copy_orthologs.csv, generated in the previous gene_classification
      run.
    inputBinding:
      position: 102
      prefix: --homology-file=
      separate: false
  - id: homology_groups
    type:
      - 'null'
      - string
    doc: A list of homology group node identifiers of single copy groups. Default
      is single_copy_orthologs.csv, generated in the previous gene_classification
      run.
    inputBinding:
      position: 102
      prefix: --homology-groups=
      separate: false
  - id: align_protein
    type:
      - 'null'
      - boolean
    doc: Use protein alignment.
    inputBinding:
      position: 102
      prefix: --align-protein
  - id: align_nucleotide
    type:
      - 'null'
      - boolean
    doc: Use nucleotide alignment.
    inputBinding:
      position: 102
      prefix: --align-nucleotide
  - id: phenotype
    type:
      - 'null'
      - string
    doc: Include phenotype information in the resulting phylogeny.
    inputBinding:
      position: 102
      prefix: --phenotype=
      separate: false
  - id: phasing
    type:
      - 'null'
      - boolean
    doc: Analyse phased genomes.
    inputBinding:
      position: 102
      prefix: --phasing
  - id: variants
    type:
      - 'null'
      - boolean
    doc: Use included variation (VCF information).
    inputBinding:
      position: 102
      prefix: --variants
  - id: pavs
    type:
      - 'null'
      - boolean
    doc: Use included variation (PAV information).
    inputBinding:
      position: 102
      prefix: --pavs
  - id: clustering_mode
    type:
      - 'null'
      - string
    doc: Maximum likelihood (ML) or Neighbour joining (NJ). Default is ML.
    inputBinding:
      position: 102
      prefix: --clustering-mode=
      separate: false
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
stdout: pantools_core_phylogeny.log
