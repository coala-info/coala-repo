cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pstools
  - resolve_haplotypes
label: pstools_resolve_haplotypes
doc: "Resolve haplotypes using Hi-C mapping and GFA files\n\nTool homepage: https://github.com/shilpagarg/pstools"
inputs:
  - id: hic_mapping_file
    type: File
    doc: Hi-C mapping file
    inputBinding:
      position: 1
  - id: gfa_file
    type: File
    doc: GFA file
    inputBinding:
      position: 2
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 8
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: output_directory
    type: Directory
    doc: Output directory
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pstools:0.2a3--h077b44d_4
