cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mgatk-del-find
label: mgatk_mgatk-del-find
doc: "mgatk-del-find: detect possible deletion junctions from bam files. Writes the
  clipped-read table (.clip.tsv) and the supplementary-alignment table (.SA.tsv)
  and then plots the junctions.\n\nTool homepage: https://github.com/caleblareau/mgatk"
inputs:
  - id: input
    type: File
    secondaryFiles:
      - .bai
    doc: Input; a single .bam file of reads to be processed.
    inputBinding:
      position: 101
      prefix: --input
  - id: mito_chromosome
    type: string
    doc: Name of mtDNA chromosome in bam file (e.g. chrM or MT)
    inputBinding:
      position: 101
      prefix: --mito-chromosome
  - id: output
    type: string
    doc: Name of output files prefix
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Clipped-read table, supplementary-alignment table and plots
    outputBinding:
      glob: $(inputs.output).*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgatk:0.7.0--pyhdfd78af_2
