cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - assess_homopolymers
  - analyse
label: pomoxis_assess_homopolymers_analyse
doc: "Analyse existing homopolymer counts, optionally merging multiple counters.\n\nTool homepage: https://github.com/nanoporetech/pomoxis"
inputs:
  - id: pkl
    type:
      type: array
      items: File
    doc: Input .pkl file(s) from `assess_homopolymers count`.
    inputBinding:
      position: 1
  - id: output_dir
    type:
      - 'null'
      - string
    default: homopolymers
    doc: Output directory (will be created).
    inputBinding:
      position: 102
      prefix: --output_dir
outputs:
  - id: analysis_dir
    type: Directory
    doc: Directory with the homopolymer analysis tables and plots.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
