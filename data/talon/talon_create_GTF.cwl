cwlVersion: v1.2
class: CommandLineTool
baseCommand: talon_create_GTF
label: talon_create_GTF
doc: "Write a GTF annotation of the transcripts in a TALON database, optionally restricted to a whitelist or to observed transcripts.\n\nTool homepage: https://github.com/mortazavilab/TALON"
inputs:
  - id: database
    type: File
    doc: "TALON database"
    inputBinding:
      position: 101
      prefix: --db
  - id: genome_build
    type: string
    doc: "Genome build to use. Note: must be in the TALON database."
    inputBinding:
      position: 101
      prefix: --build
  - id: annot
    type: string
    doc: "Which annotation version to use. Will determine which annotation transcripts are considered known or novel relative to. Note: must be in the TALON database."
    inputBinding:
      position: 101
      prefix: --annot
  - id: whitelist
    type:
      - 'null'
      - File
    doc: "Whitelist file of transcripts to include in the output. First column should be TALON gene ID, second column should be TALON transcript ID"
    inputBinding:
      position: 101
      prefix: --whitelist
  - id: observed
    type:
      - 'null'
      - boolean
    doc: "If this option is set, the GTF file will only include transcripts that were observed in at least one dataset (redundant if dataset file provided)."
    inputBinding:
      position: 101
      prefix: --observed
  - id: datasets
    type:
      - 'null'
      - File
    doc: "Optional: A file indicating which datasets should be included (one dataset name per line). Default is to include all datasets."
    inputBinding:
      position: 101
      prefix: --datasets
  - id: outprefix
    type: string
    doc: "Prefix for output GTF"
    inputBinding:
      position: 101
      prefix: --o
outputs:
  - id: gtf
    type: File
    doc: "TALON GTF annotation"
    outputBinding:
      glob: $(inputs.outprefix)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/talon:6.0.1--pyhdfd78af_0
