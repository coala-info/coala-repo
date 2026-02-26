cwlVersion: v1.2
class: CommandLineTool
baseCommand: sherpas_SHERPAS
label: sherpas_SHERPAS
doc: "Screening Historical Events of Recombination in a Phylogeny via Ancestral Sequences\n\
  \nTool homepage: https://github.com/phylo42/sherpas"
inputs:
  - id: circularity_options
    type:
      - 'null'
      - boolean
    doc: Activates circularity options (to be used for circular queries)
    inputBinding:
      position: 101
      prefix: -c
  - id: disable_post_treatment
    type:
      - 'null'
      - boolean
    doc: Disables post-treatment of unassigned regions
    inputBinding:
      position: 101
      prefix: -k
  - id: method
    type:
      - 'null'
      - string
    doc: Method (F or R)
    default: F
    inputBinding:
      position: 101
      prefix: -m
  - id: output_layout
    type:
      - 'null'
      - boolean
    doc: Changes output layout
    inputBinding:
      position: 101
      prefix: -l
  - id: phylo_kmer_database
    type: Directory
    doc: Path to the phylo-kmer database
    inputBinding:
      position: 101
      prefix: -d
  - id: query_file
    type: File
    doc: Path to the query file
    inputBinding:
      position: 101
      prefix: -q
  - id: strain_alignment_file
    type: File
    doc: Path to the strain-alignment file
    inputBinding:
      position: 101
      prefix: -g
  - id: threshold
    type:
      - 'null'
      - float
    doc: Threshold for unassigned regions
    default: 100 [F] or 0.99 [R]
    inputBinding:
      position: 101
      prefix: -t
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size
    default: 300
    inputBinding:
      position: 101
      prefix: -w
outputs:
  - id: output_directory
    type: Directory
    doc: Path to the output directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sherpas:1.0.2--h9948957_6
