cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - Bandage
  - querypaths
label: bandage_querypaths
doc: "Bandage querypaths searches for queries in the graph using BLAST and outputs\
  \ the results to a tab-delimited file.\n\nTool homepage: https://github.com/rrwick/Bandage"
inputs:
  - id: graph
    type: File
    doc: A graph file of any type supported by Bandage
    inputBinding:
      position: 1
  - id: queries
    type: File
    doc: A FASTA file of one or more BLAST queries
    inputBinding:
      position: 2
  - id: output_prefix
    type: string
    doc: The output file prefix (used to create the '.tsv' output file, and possibly
      FASTA files as well)
    inputBinding:
      position: 3
  - id: pathfasta
    type:
      - 'null'
      - boolean
    doc: Put all query path sequences in a multi-FASTA file, not in the TSV file
    inputBinding:
      position: 4
      prefix: --pathfasta
  - id: hitsfasta
    type:
      - 'null'
      - boolean
    doc: Produce a multi-FASTA file of all BLAST hits in the query paths
    inputBinding:
      position: 4
      prefix: --hitsfasta
outputs:
  - id: paths_tsv
    type: File
    doc: Tab-delimited query path table
    outputBinding:
      glob: $(inputs.output_prefix).tsv
  - id: fasta_files
    type: File[]
    doc: Query path and BLAST hit FASTA files (with --pathfasta or --hitsfasta)
    outputBinding:
      glob: $(inputs.output_prefix)*.fasta
requirements:
  - class: EnvVarRequirement
    envDef:
      QT_QPA_PLATFORM: offscreen
      XDG_RUNTIME_DIR: /tmp
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bandage:0.9.0--h9948957_0
