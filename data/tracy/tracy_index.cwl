cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tracy
  - index
label: tracy_index
doc: "Index a genome for tracy\n\nTool homepage: https://github.com/gear-genomics/tracy"
inputs:
  - id: genome_fasta
    type: File
    doc: Input genome fasta file (e.g., genome.fa.gz)
    inputBinding:
      position: 1
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tracy:0.8.1--h4d20210_0
