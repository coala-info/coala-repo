cwlVersion: v1.2
class: CommandLineTool
baseCommand: eukcc single
label: eukcc_single
doc: "eukcc single: error: the following arguments are required: fasta\n\nTool homepage:
  https://github.com/Finn-Lab/EukCC/"
inputs:
  - id: fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: aa
    type:
      - 'null'
      - boolean
    doc: Use amino acid sequences
    inputBinding:
      position: 102
      prefix: --AA
  - id: clade
    type:
      - 'null'
      - string
    doc: Specify a clade
    inputBinding:
      position: 102
      prefix: --clade
  - id: comparison_genomes
    type:
      - 'null'
      - type: array
        items: string
    doc: List of genomes for comparison
    inputBinding:
      position: 102
      prefix: --genomes
  - id: db
    type:
      - 'null'
      - Directory
    doc: Database directory
    inputBinding:
      position: 102
      prefix: --db
  - id: dna
    type:
      - 'null'
      - boolean
    doc: Use DNA sequences
    inputBinding:
      position: 102
      prefix: --DNA
  - id: extra
    type:
      - 'null'
      - boolean
    doc: Include extra information
    inputBinding:
      position: 102
      prefix: --extra
  - id: gmes
    type:
      - 'null'
      - boolean
    doc: Use GMES
    inputBinding:
      position: 102
      prefix: --gmes
  - id: ignore_tree
    type:
      - 'null'
      - boolean
    doc: Ignore the tree
    inputBinding:
      position: 102
      prefix: --ignore_tree
  - id: keep
    type:
      - 'null'
      - boolean
    doc: Keep intermediate files
    inputBinding:
      position: 102
      prefix: --keep
  - id: marker_prevalence
    type:
      - 'null'
      - float
    doc: Marker prevalence threshold
    inputBinding:
      position: 102
      prefix: --marker_prevalence
  - id: max_set_size
    type:
      - 'null'
      - int
    doc: Maximum size of the set
    inputBinding:
      position: 102
      prefix: --max_set_size
  - id: no_dynamic_root
    type:
      - 'null'
      - boolean
    doc: Do not use dynamic root
    inputBinding:
      position: 102
      prefix: --no_dynamic_root
  - id: rerun
    type:
      - 'null'
      - boolean
    doc: Rerun analysis
    inputBinding:
      position: 102
      prefix: --rerun
  - id: select_best_guess
    type:
      - 'null'
      - boolean
    doc: Select the best guess species
    inputBinding:
      position: 102
      prefix: --select_best_guess
  - id: select_species
    type:
      - 'null'
      - boolean
    doc: Select species
    inputBinding:
      position: 102
      prefix: --select_species
  - id: set_number_species
    type:
      - 'null'
      - int
    doc: Number of species in the set
    inputBinding:
      position: 102
      prefix: --set_number_species
  - id: set_size
    type:
      - 'null'
      - int
    doc: Size of the set of species
    inputBinding:
      position: 102
      prefix: --set_size
  - id: simple
    type:
      - 'null'
      - boolean
    doc: Simple mode
    inputBinding:
      position: 102
      prefix: --simple
  - id: taxids
    type:
      - 'null'
      - type: array
        items: string
    doc: List of taxids to consider
    inputBinding:
      position: 102
      prefix: --taxids
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: threads_epa
    type:
      - 'null'
      - int
    doc: Number of threads for EPA
    inputBinding:
      position: 102
      prefix: --threads_epa
  - id: use_ncbi_tree
    type:
      - 'null'
      - boolean
    doc: Use NCBI tree
    inputBinding:
      position: 102
      prefix: --use_ncbi_tree
  - id: use_placement
    type:
      - 'null'
      - string
    doc: Use placement file
    inputBinding:
      position: 102
      prefix: --use_placement
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Output directory
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eukcc:2.1.3--pyhdfd78af_0
