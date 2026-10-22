cwlVersion: v1.2
class: CommandLineTool
baseCommand: talon_create_adata
label: talon_create_adata
doc: "Create an AnnData object of TALON transcript (or gene) counts per dataset.\n\nTool homepage: https://github.com/mortazavilab/TALON"
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
  - id: pass_list
    type:
      - 'null'
      - File
    doc: "Pass list file of transcripts to include in the output. First column should be TALON gene ID, second column should be TALON transcript ID"
    inputBinding:
      position: 101
      prefix: --pass_list
  - id: genome_build
    type: string
    doc: "Genome build to use. Note: must be in the TALON database."
    inputBinding:
      position: 101
      prefix: --build
  - id: gene
    type:
      - 'null'
      - boolean
    doc: "Output AnnData on the gene level rather than the transcript"
    inputBinding:
      position: 101
      prefix: --gene
  - id: datasets
    type:
      - 'null'
      - File
    doc: "Optional: A file indicating which datasets should be included (one dataset name per line). Default is to include all datasets."
    inputBinding:
      position: 101
      prefix: --datasets
  - id: outfile
    type: string
    doc: "Output file name"
    inputBinding:
      position: 101
      prefix: --o
outputs:
  - id: adata
    type: File
    doc: "AnnData file"
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/talon:6.0.1--pyhdfd78af_0
