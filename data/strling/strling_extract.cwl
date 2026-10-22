cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - strling
  - extract
label: strling_extract
doc: "Extract STRs from BAM file\n\nTool homepage: https://github.com/quinlan-lab/STRling"
inputs:
  - id: bam
    type: File
    doc: path to bam file
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
      - pattern: .crai
        required: false
      - pattern: ^.crai
        required: false
    inputBinding:
      position: 101
  - id: bin
    type: string
    doc: path bin to output bin file to be created
    inputBinding:
      position: 102
  - id: fasta
    type:
      - 'null'
      - File
    doc: path to fasta file (required for CRAM)
    secondaryFiles:
      - pattern: .fai
        required: true
    inputBinding:
      position: 1
      prefix: --fasta
  - id: genome_repeats
    type:
      - 'null'
      - string
    doc: optional path to genome repeats file. if it does not exist, it will be
      created
    inputBinding:
      position: 1
      prefix: --genome-repeats
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: minimum mapping quality (does not apply to STR reads)
    inputBinding:
      position: 1
      prefix: --min-mapq
  - id: proportion_repeat
    type:
      - 'null'
      - float
    doc: proportion of read that is repetitive to be considered as STR
    inputBinding:
      position: 1
      prefix: --proportion-repeat
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: out_bin
    type: File
    doc: path bin to output bin file to be created
    outputBinding:
      glob: '$(inputs.bin)'
  - id: genome_repeats_out
    type:
      - 'null'
      - File
    doc: genome repeats file created when genome_repeats names a new file
    outputBinding:
      glob: $(inputs.genome_repeats)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strling:0.6.0--h7b50bb2_0
