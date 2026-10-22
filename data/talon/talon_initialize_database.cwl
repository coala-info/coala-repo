cwlVersion: v1.2
class: CommandLineTool
baseCommand: talon_initialize_database
label: talon_initialize_database
doc: "Initialize a TALON SQLite database from a GTF annotation containing genes, transcripts and edges.\n\nTool homepage: https://github.com/mortazavilab/TALON"
inputs:
  - id: gtf
    type: File
    doc: GTF annotation containing genes, transcripts, and edges.
    inputBinding:
      position: 101
      prefix: --f
  - id: genome_build
    type: string
    doc: Name of genome build that the GTF file is based on (ie hg38)
    inputBinding:
      position: 101
      prefix: --g
  - id: annot_name
    type: string
    doc: Name of supplied annotation (will be used to label data)
    inputBinding:
      position: 101
      prefix: --a
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum required transcript length (default = 0 bp)
    inputBinding:
      position: 101
      prefix: --l
  - id: id_prefix
    type:
      - 'null'
      - string
    doc: Prefix for naming novel discoveries in eventual TALON runs
    inputBinding:
      position: 101
      prefix: --idprefix
  - id: cutoff_5p
    type:
      - 'null'
      - int
    doc: Maximum allowable distance (bp) at the 5' end during annotation
    inputBinding:
      position: 101
      prefix: --5p
  - id: cutoff_3p
    type:
      - 'null'
      - int
    doc: Maximum allowable distance (bp) at the 3' end during annotation
    inputBinding:
      position: 101
      prefix: --3p
  - id: outprefix
    type: string
    doc: Outprefix for the annotation files
    inputBinding:
      position: 101
      prefix: --o
outputs:
  - id: database
    type: File
    doc: TALON SQLite database
    outputBinding:
      glob: $(inputs.outprefix).db
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/talon:6.0.1--pyhdfd78af_0
