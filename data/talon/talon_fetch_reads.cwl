cwlVersion: v1.2
class: CommandLineTool
baseCommand: talon_fetch_reads
label: talon_fetch_reads
doc: "Query a TALON database to get read-specific annotation information.\n\nTool homepage: https://github.com/mortazavilab/TALON"
inputs:
  - id: database
    type: File
    doc: TALON database
    inputBinding:
      position: 101
      prefix: --db
  - id: genome_build
    type: string
    doc: Genome build (i.e. hg38) to use. Must be in the database.
    inputBinding:
      position: 101
      prefix: --build
  - id: datasets
    type:
      - 'null'
      - string
    doc: "Optional: Comma-delimited list of datasets to include. Default behavior is to include all datasets in the database."
    inputBinding:
      position: 101
      prefix: --datasets
  - id: outprefix
    type: string
    doc: Prefix for output files
    inputBinding:
      position: 101
      prefix: --o
outputs:
  - id: read_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in outprefix
    outputBinding:
      glob: $(inputs.outprefix)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/talon:6.0.1--pyhdfd78af_0
