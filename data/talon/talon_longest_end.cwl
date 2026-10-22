cwlVersion: v1.2
class: CommandLineTool
baseCommand: talon_longest_end
label: talon_longest_end
doc: "Replace the starts or ends of transcripts in a GTF with the longest alternatives (similar to the GENCODE model of calling transcripts).\n\nTool homepage: https://github.com/mortazavilab/TALON"
inputs:
  - id: gtf
    type: File
    doc: TALON GTF to serve as the template to modify
    inputBinding:
      position: 101
      prefix: -gtf
  - id: read_annot
    type: File
    doc: Read annot file from TALON to extract raw read ends from
    inputBinding:
      position: 101
      prefix: -read_annot
  - id: datasets
    type:
      - 'null'
      - File
    doc: A file indicating which datasets should be included (one dataset name per line). Default is to include all datasets.
    inputBinding:
      position: 101
      prefix: --datasets
  - id: mode
    type:
      - 'null'
      - string
    doc: "Modify TSSs or TESs, 'tss', 'tes', 'both'. Default: 'tss'"
    inputBinding:
      position: 101
      prefix: --mode
  - id: novelty
    type:
      - 'null'
      - string
    doc: "Whether to only modify ends from novel or all models, 'all' or 'novel'. Default: 'all'"
    inputBinding:
      position: 101
      prefix: --novelty
  - id: outprefix
    type: string
    doc: Prefix for output file
    inputBinding:
      position: 101
      prefix: -outprefix
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Display in progress output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: longest_end_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in outprefix
    outputBinding:
      glob: $(inputs.outprefix)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/talon:6.0.1--pyhdfd78af_0
