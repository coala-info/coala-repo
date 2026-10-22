cwlVersion: v1.2
class: CommandLineTool
baseCommand: talon_get_sjs
label: talon_get_sjs
doc: "Extract the locations, novelty, and transcript assignments of exons or introns in a TALON database or GTF file. All positions are 1-based.\n\nTool homepage: https://github.com/mortazavilab/TALON"
inputs:
  - id: gtf
    type:
      - 'null'
      - File
    doc: TALON GTF file from which to extract exons/introns
    inputBinding:
      position: 101
      prefix: --gtf
  - id: database
    type:
      - 'null'
      - File
    doc: TALON database from which to extract exons/introns
    inputBinding:
      position: 101
      prefix: --db
  - id: ref_gtf
    type:
      - 'null'
      - File
    doc: GTF reference file (ie GENCODE). Will be used to label novelty.
    inputBinding:
      position: 101
      prefix: --ref
  - id: mode
    type:
      - 'null'
      - string
    doc: Choices are 'intron' or 'exon' (default is 'intron'). Determines whether to include introns or exons in the output
    inputBinding:
      position: 101
      prefix: --mode
  - id: outprefix
    type: string
    doc: Prefix for output file
    inputBinding:
      position: 101
      prefix: --outprefix
outputs:
  - id: sj_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in outprefix
    outputBinding:
      glob: $(inputs.outprefix)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/talon:6.0.1--pyhdfd78af_0
