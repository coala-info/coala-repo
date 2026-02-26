cwlVersion: v1.2
class: CommandLineTool
baseCommand: gapseq
label: gapseq_doall
doc: "Informed prediction and analysis of bacterial metabolic pathways and genome-scale
  networks\n\nTool homepage: https://github.com/jotech/gapseq"
inputs:
  - id: subcommand
    type: string
    doc: Subcommand to execute (test, find, find-transport, draft, medium, fill,
      doall, adapt, pan)
    inputBinding:
      position: 1
  - id: genome
    type:
      - 'null'
      - File
    doc: Input genome file (e.g., .faa.gz, .fna.gz)
    inputBinding:
      position: 2
  - id: medium
    type:
      - 'null'
      - File
    doc: Input medium file
    inputBinding:
      position: 3
  - id: organism_type
    type:
      - 'null'
      - string
    doc: Organism type (Bacteria or Archaea)
    inputBinding:
      position: 4
  - id: bitscore
    type:
      - 'null'
      - string
    doc: Bitscore threshold for homology search
    inputBinding:
      position: 105
      prefix: -b
  - id: draft_list
    type:
      - 'null'
      - type: array
        items: File
    doc: List of draft models for pan-genome reconstruction
    inputBinding:
      position: 105
      prefix: -m
  - id: draft_model
    type:
      - 'null'
      - File
    doc: Input draft model file
    inputBinding:
      position: 105
      prefix: -m
  - id: enzymes
    type:
      - 'null'
      - string
    doc: Specify enzymes for analysis
    inputBinding:
      position: 105
      prefix: -e
  - id: growh_compounds
    type:
      - 'null'
      - string
    doc: Growth compounds for adaptation
    inputBinding:
      position: 105
      prefix: -w
  - id: medium_file
    type:
      - 'null'
      - File
    doc: Input medium file for gap filling
    inputBinding:
      position: 105
      prefix: -n
  - id: pathways
    type:
      - 'null'
      - string
    doc: Specify pathways for analysis or draft
    inputBinding:
      position: 105
      prefix: -p
  - id: pathways_list
    type:
      - 'null'
      - type: array
        items: File
    doc: List of pathways for pan-genome reconstruction
    inputBinding:
      position: 105
      prefix: -w
  - id: reaction_blast_file
    type:
      - 'null'
      - File
    doc: Reaction BLAST file for adaptation
    inputBinding:
      position: 105
      prefix: -b
  - id: reactions
    type:
      - 'null'
      - File
    doc: Input reactions file
    inputBinding:
      position: 105
      prefix: -r
  - id: rxn_genes
    type:
      - 'null'
      - File
    doc: Input reaction genes file
    inputBinding:
      position: 105
      prefix: -g
  - id: rxn_genes_list
    type:
      - 'null'
      - type: array
        items: File
    doc: List of reaction genes for pan-genome reconstruction
    inputBinding:
      position: 105
      prefix: -g
  - id: rxn_weights
    type:
      - 'null'
      - File
    doc: Input reaction weights file
    inputBinding:
      position: 105
      prefix: -c
  - id: rxn_weights_list
    type:
      - 'null'
      - type: array
        items: File
    doc: List of reaction weights for pan-genome reconstruction
    inputBinding:
      position: 105
      prefix: -c
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for sequence alignments
    inputBinding:
      position: 105
      prefix: -K
  - id: transporter
    type:
      - 'null'
      - File
    doc: Input transporter file
    inputBinding:
      position: 105
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable noisy verbose mode
    inputBinding:
      position: 105
      prefix: -n
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gapseq:1.4.0--h9ee0642_1
