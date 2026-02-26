cwlVersion: v1.2
class: CommandLineTool
baseCommand: minipolish
label: minipolish
doc: "Minipolish\n\nTool homepage: https://github.com/rrwick/Minipolish"
inputs:
  - id: reads
    type: File
    doc: Long reads for polishing (FASTA or FASTQ format)
    inputBinding:
      position: 1
  - id: assembly
    type: File
    doc: Miniasm assembly to be polished (GFA format)
    inputBinding:
      position: 2
  - id: minimap2_preset
    type:
      - 'null'
      - string
    doc: 'minimap2 preset to use: "map-ont" for Oxford Nanopore reads with <Q20 accuracy,
      "lr:hq" for Oxford Nanopore reads with Q20+ accuracy, "map-pb" for PacBio CLR
      or "map-hifi" for PacBio HiFi/CCS'
    default: map-ont
    inputBinding:
      position: 103
      prefix: --minimap2-preset
  - id: pacbio
    type:
      - 'null'
      - boolean
    doc: 'Deprecated: equivalent to --minimap2-preset map-pb. Retained for backwards
      compatibility.'
    inputBinding:
      position: 103
      prefix: --pacbio
  - id: rounds
    type:
      - 'null'
      - int
    doc: Number of full Racon polishing rounds
    default: 2
    inputBinding:
      position: 103
      prefix: --rounds
  - id: skip_initial
    type:
      - 'null'
      - boolean
    doc: 'Skip the initial polishing round - appropriate if the input GFA does not
      have "a" lines (default: do the initial polishing round)'
    inputBinding:
      position: 103
      prefix: --skip_initial
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for alignment and polishing
    default: 16
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minipolish:0.2.0--pyhdfd78af_0
stdout: minipolish.out
