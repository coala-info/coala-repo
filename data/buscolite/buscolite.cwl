cwlVersion: v1.2
class: CommandLineTool
baseCommand: buscolite
label: buscolite
doc: "BUSCOlite: simplified BUSCO analysis for genome annotation\n\nTool homepage:
  https://github.com/nextgenusfs/buscolite"
inputs:
  - id: cpus
    type:
      - 'null'
      - int
    doc: Specify the number (N=integer) of threads/cores to use.
    inputBinding:
      position: 101
      prefix: --cpus
  - id: flanks
    type:
      - 'null'
      - int
    doc: "Length of flanking region to use for augustus prediction\n             \
      \     from miniprot hits."
    inputBinding:
      position: 101
      prefix: --flanks
  - id: input
    type: File
    doc: Input sequence file in FASTA format (genome or proteome)
    inputBinding:
      position: 101
      prefix: --input
  - id: lineage
    type: Directory
    doc: "Specify location of the BUSCO lineage data to be used (full\n          \
      \        path)."
    inputBinding:
      position: 101
      prefix: --lineage
  - id: mode
    type: string
    doc: Specify which BUSCO analysis mode to run. [genome, proteins
    inputBinding:
      position: 101
      prefix: --mode
  - id: out
    type: string
    doc: Give your analysis run a recognisable short name
    inputBinding:
      position: 101
      prefix: --out
  - id: species
    type:
      - 'null'
      - string
    doc: Name of existing Augustus species gene finding parameters.
    inputBinding:
      position: 101
      prefix: --species
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: gff3
    type:
      - 'null'
      - File
    doc: Predicted BUSCO gene models (genome mode)
    outputBinding:
      glob: $(inputs.out).buscolite.gff3
  - id: summary
    type: File
    doc: BUSCO summary table
    outputBinding:
      glob: $(inputs.out).buscolite.tsv
  - id: results_json
    type: File
    doc: Raw BUSCO results in JSON
    outputBinding:
      glob: $(inputs.out).buscolite.json
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/buscolite:26.1.26--pyhdfd78af_0
stdout: buscolite.out
