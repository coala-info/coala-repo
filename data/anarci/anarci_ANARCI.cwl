cwlVersion: v1.2
class: CommandLineTool
baseCommand: ANARCI
label: anarci_ANARCI
doc: "Antibody Numbering and Antigen Receptor ClassIfication\n\nTool homepage: http://opig.stats.ox.ac.uk/webapps/newsabdab/sabpred/anarci/"
inputs:
  - id: assign_germline
    type:
      - 'null'
      - boolean
    doc: "Assign the v and j germlines to the sequence. The most\n               \
      \         sequence identical germline is assigned."
    inputBinding:
      position: 101
      prefix: --assign_germline
  - id: bit_score_threshold
    type:
      - 'null'
      - float
    doc: "Change the bit score threshold used to confirm an\n                    \
      \    alignment should be used."
    inputBinding:
      position: 101
      prefix: --bit_score_threshold
  - id: csv
    type:
      - 'null'
      - boolean
    doc: "Write the output in csv format. Outfile must be\n                      \
      \  specified. A csv file is written for each chain type\n                  \
      \      <outfile>_<chain_type>.csv. Kappa and lambda are\n                  \
      \      considered together."
    inputBinding:
      position: 101
      prefix: --csv
  - id: hmmerpath
    type:
      - 'null'
      - Directory
    doc: "The path to the directory containing hmmer programs.\n                 \
      \       (including hmmscan)"
    inputBinding:
      position: 101
      prefix: --hmmerpath
  - id: ncpu
    type:
      - 'null'
      - int
    doc: Number of parallel processes to use. Default is 1.
    default: 1
    inputBinding:
      position: 101
      prefix: --ncpu
  - id: restrict
    type:
      - 'null'
      - type: array
        items: string
    doc: "Restrict ANARCI to only recognise certain types of\n                   \
      \     receptor chains."
    inputBinding:
      position: 101
      prefix: --restrict
  - id: scheme
    type:
      - 'null'
      - string
    doc: "Which numbering scheme should be used. i, k, c, m, w\n                 \
      \       and a are shorthand for IMGT, Kabat, Chothia, Martin\n             \
      \           (Extended Chothia), Wolfguy and Aho respectively.\n            \
      \            Default IMGT"
    default: IMGT
    inputBinding:
      position: 101
      prefix: --scheme
  - id: sequence
    type:
      - 'null'
      - string
    doc: A sequence or an input fasta file
    inputBinding:
      position: 101
      prefix: --sequence
  - id: use_species
    type:
      - 'null'
      - string
    doc: "Use a specific species in the germline assignment. If\n                \
      \        not specified, only human and mouse germlines will be\n           \
      \             considered."
    inputBinding:
      position: 101
      prefix: --use_species
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: The output file to use. Default is stdout
    outputBinding:
      glob: $(inputs.outfile)
  - id: outfile_hits
    type:
      - 'null'
      - File
    doc: "Output file for domain hit tables for each sequence.\n                 \
      \       Otherwise not output."
    outputBinding:
      glob: $(inputs.outfile_hits)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anarci:2024.05.21--pyhdfd78af_0
