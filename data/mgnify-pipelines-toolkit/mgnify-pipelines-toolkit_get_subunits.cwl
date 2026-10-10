cwlVersion: v1.2
class: CommandLineTool
baseCommand: get_subunits
label: mgnify-pipelines-toolkit_get_subunits
doc: "Extract lsu, ssu and 5s and other models\n\nTool homepage: https://github.com/EBI-Metagenomics/mgnify-pipelines-toolkit"
inputs:
  - id: input
    type: File
    doc: Input fasta file
    inputBinding:
      position: 101
      prefix: --input
  - id: name
    type: string
    doc: Accession
    inputBinding:
      position: 101
      prefix: --name
  - id: prefix
    type:
      - 'null'
      - string
    doc: prefix for models
    inputBinding:
      position: 101
      prefix: --prefix
  - id: separate_subunits_by_models
    type:
      - 'null'
      - boolean
    doc: 'Create separate files for each kingdon example: sample_SSU_rRNA_eukarya.RF01960.fasta'
    inputBinding:
      position: 101
      prefix: --separate-subunits-by-models
outputs:
  - id: sequence_categorisation
    type: Directory
    doc: Directory sequence-categorisation with the extracted subunit FASTA files (SSU, LSU, 5S, 5.8S, other ncRNA, and one file per model with --separate-subunits-by-models)
    outputBinding:
      glob: sequence-categorisation
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/mgnify-pipelines-toolkit:1.4.16--pyhdfd78af_0
stdout: mgnify-pipelines-toolkit_get_subunits.out
