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
    secondaryFiles:
      - .fai
    doc: Input genome fasta file (e.g., genome.fa.gz)
    inputBinding:
      position: 1
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tracy:0.8.1--h4d20210_0
