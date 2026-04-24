cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - genometreetk
  - derep_tree
label: genometreetk_derep_tree
doc: "Dereplicate tree to taxa of interest.\n\nTool homepage: http://pypi.python.org/pypi/genometreetk/"
inputs:
  - id: input_tree
    type: File
    doc: tree to dereplicate
    inputBinding:
      position: 1
  - id: lineage_of_interest
    type: string
    doc: named lineage where all taxa should be retain
    inputBinding:
      position: 2
  - id: outgroup
    type: string
    doc: named lineage to use as outgroup
    inputBinding:
      position: 3
  - id: gtdb_metadata
    type: File
    doc: GTDB metadata for taxa in tree
    inputBinding:
      position: 4
  - id: keep_unclassified
    type:
      - 'null'
      - boolean
    doc: keep all taxa in unclassified lineages
    inputBinding:
      position: 105
      prefix: --keep_unclassified
  - id: msa_file
    type:
      - 'null'
      - File
    doc: multiple sequence alignment to dereplicate
    inputBinding:
      position: 105
      prefix: --msa_file
  - id: silent
    type:
      - 'null'
      - boolean
    doc: suppress output
    inputBinding:
      position: 105
      prefix: --silent
  - id: taxa_to_retain
    type:
      - 'null'
      - int
    doc: number of taxa to sample from dereplicated lineages
    inputBinding:
      position: 105
      prefix: --taxa_to_retain
outputs:
  - id: output_dir
    type: Directory
    doc: output directory
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genometreetk:0.1.6--py_2
