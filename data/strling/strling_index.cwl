cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - strling
  - index
label: strling_index
doc: "Index a FASTA file for STR analysis.\n\nTool homepage: https://github.com/quinlan-lab/STRling"
inputs:
  - id: fasta
    type: File
    doc: path to fasta file
    secondaryFiles:
      - pattern: .fai
        required: true
    inputBinding:
      position: 101
  - id: proportion_repeat
    type:
      - 'null'
      - float
    doc: proportion of read that is repetitive to be considered as STR
    inputBinding:
      position: 1
      prefix: --proportion-repeat
  - id: genome_repeats_path
    type:
      - 'null'
      - string
    doc: optional path to output genome repeats file (default ./<FASTA>.str)
    inputBinding:
      position: 1
      prefix: --genome-repeats
outputs:
  - id: genome_repeats
    type: File
    doc: genome repeats file (STR loci found in the reference)
    outputBinding:
      glob: $(inputs.genome_repeats_path || (inputs.fasta.basename + '.str'))
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strling:0.6.0--h7b50bb2_0
