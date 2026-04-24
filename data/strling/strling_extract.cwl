cwlVersion: v1.2
class: CommandLineTool
baseCommand: strling_extract
label: strling_extract
doc: "Extract STRs from BAM file\n\nTool homepage: https://github.com/quinlan-lab/STRling"
inputs:
  - id: bam
    type: File
    doc: path to bam file
    inputBinding:
      position: 1
  - id: fasta
    type: File
    doc: path to fasta file (required for CRAM)
    inputBinding:
      position: 102
      prefix: --fasta
  - id: genome_repeats
    type:
      - 'null'
      - File
    doc: optional path to genome repeats file. if it does not exist, it will be 
      created
    inputBinding:
      position: 102
      prefix: --genome-repeats
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: minimum mapping quality (does not apply to STR reads)
    inputBinding:
      position: 102
      prefix: --min-mapq
  - id: proportion_repeat
    type:
      - 'null'
      - float
    doc: proportion of read that is repetitive to be considered as STR
    inputBinding:
      position: 102
      prefix: --proportion-repeat
  - id: verbose
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: bin
    type: File
    doc: path bin to output bin file to be created
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strling:0.6.0--h7b50bb2_0
