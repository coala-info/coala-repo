cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfba
label: pyfba_gapfill_two_media
doc: "Import a list of reactions and then iterate through our gapfilling steps to
  see when we get growth. You can specify a single --growth & --nogrowth media conditions\n\
  \nTool homepage: https://linsalrob.github.io/PyFBA/"
inputs:
  - id: close_genomes
    type:
      - 'null'
      - type: array
        items: File
    doc: close genomes reactions file. Multiple files are allowed
    inputBinding:
      position: 101
      prefix: --close_genomes
  - id: growth
    type: File
    doc: media file on which the organism can grow
    inputBinding:
      position: 101
      prefix: --growth
  - id: nogrowth
    type:
      - 'null'
      - File
    doc: media file on which the organism can NOT grow
    inputBinding:
      position: 101
      prefix: --nogrowth
  - id: reactions
    type: File
    doc: reactions file
    inputBinding:
      position: 101
      prefix: --reactions
  - id: type
    type:
      - 'null'
      - string
    doc: organism type for the model (currently allowed are ['gramnegative', 
      'grampositive', 'microbial', 'mycobacteria', 'plant']). 
      Default=gramnegative
    default: gramnegative
    inputBinding:
      position: 101
      prefix: --type
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type: File
    doc: file to save new reaction list to
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfba:2.62--py38h3df17bf_5
