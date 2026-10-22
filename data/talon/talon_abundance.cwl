cwlVersion: v1.2
class: CommandLineTool
baseCommand: talon_abundance
label: talon_abundance
doc: "Create an abundance matrix of TALON transcripts across datasets, optionally restricted to a whitelist of transcripts.\n\nTool homepage: https://github.com/mortazavilab/TALON"
inputs:
  - id: database
    type: File
    doc: "TALON database"
    inputBinding:
      position: 101
      prefix: --db
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
  - id: genome_build
    type: string
    doc: "Genome build to use. Note: must be in the TALON database."
    inputBinding:
      position: 101
      prefix: --build
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
    doc: "Prefix for output file"
    inputBinding:
      position: 101
      prefix: --o
outputs:
  - id: abundance
    type: File
    doc: "Abundance matrix"
    outputBinding:
      glob: $(inputs.outprefix)_talon_abundance*.tsv
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/talon:6.0.1--pyhdfd78af_0
