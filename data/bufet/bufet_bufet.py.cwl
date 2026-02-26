cwlVersion: v1.2
class: CommandLineTool
baseCommand: python bufet.py
label: bufet_bufet.py
doc: "Run BUFET analysis\n\nTool homepage: https://github.com/diwis/BUFET/"
inputs:
  - id: disable_file_check
    type:
      - 'null'
      - boolean
    doc: (quicker but not recommended) disable all file validations.
    inputBinding:
      position: 101
      prefix: --disable-file-check
  - id: disable_interactions_check
    type:
      - 'null'
      - boolean
    doc: (quicker but not recommended) disable existence and file format 
      validation for the interactions file.
    inputBinding:
      position: 101
      prefix: --disable-interactions-check
  - id: disable_ontology_check
    type:
      - 'null'
      - boolean
    doc: (quicker but not recommended) disable existence and file format 
      validation for the ontology file.
    inputBinding:
      position: 101
      prefix: --disable-ontology-check
  - id: disable_synonyms_check
    type:
      - 'null'
      - boolean
    doc: (quicker but not recommended) disable existence and file format 
      validation for the synonyms file.
    inputBinding:
      position: 101
      prefix: --disable-synonyms-check
  - id: interactions_file
    type: File
    doc: path to the interactions file
    inputBinding:
      position: 101
      prefix: -interactions
  - id: iterations
    type:
      - 'null'
      - int
    doc: number of random permutations
    inputBinding:
      position: 101
      prefix: -iterations
  - id: mifree
    type:
      - 'null'
      - float
    doc: miRanda free energy (valid only if the --miRanda flag is invoked)
    inputBinding:
      position: 101
      prefix: -miFree
  - id: mirna_file
    type: File
    doc: path to the miRNA group file
    inputBinding:
      position: 101
      prefix: -miRNA
  - id: miscore
    type:
      - 'null'
      - float
    doc: miRanda free energy (valid only if the --miRanda flag is invoked)
    inputBinding:
      position: 101
      prefix: -miScore
  - id: ontology_file
    type: File
    doc: path to the ontology file
    inputBinding:
      position: 101
      prefix: -ontology
  - id: processors
    type:
      - 'null'
      - int
    doc: number of threads to use for calculations
    inputBinding:
      position: 101
      prefix: -processors
  - id: species
    type:
      - 'null'
      - string
    doc: '"human" or "mouse"'
    inputBinding:
      position: 101
      prefix: -species
  - id: synonyms_file
    type: File
    doc: path to the synonyms file
    inputBinding:
      position: 101
      prefix: -synonyms
  - id: use_ensgo
    type:
      - 'null'
      - boolean
    doc: use ontology file downloaded from Ensembl
    inputBinding:
      position: 101
      prefix: --ensGO
  - id: use_miranda
    type:
      - 'null'
      - boolean
    doc: use interactions file from miRanda run
    inputBinding:
      position: 101
      prefix: --miRanda
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: path to the output file (overwritten if it exists)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bufet:1.0--py35h470a237_0
