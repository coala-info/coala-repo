cwlVersion: v1.2
class: CommandLineTool
baseCommand: varlociraptor-methylation-candidates
label: varlociraptor_methylation-candidates
doc: "Generate BCF with methylation candidates\n\nTool homepage: https://varlociraptor.github.io"
inputs:
  - id: input
    type: File
    doc: Input FASTA File
    inputBinding:
      position: 1
  - id: motifs
    type:
      - 'null'
      - type: array
        items: string
    doc: "Comma-separated list of methylation motifs to search for in the input chromosome.\n\
      \                                Supported motifs: CG, CHG, CHH, GATC."
    inputBinding:
      position: 102
      prefix: --motifs
outputs:
  - id: output
    type: File
    doc: Output BCF File
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varlociraptor:8.9.5--h24073b4_0
