cwlVersion: v1.2
class: CommandLineTool
baseCommand: goleft
label: goleft_indexcov
doc: "Estimate coverage for BAM files\n\nTool homepage: https://github.com/brentp/goleft"
inputs:
  - id: bams
    type:
      type: array
      items: File
    doc: bam(s) or crais for which to estimate coverage
    inputBinding:
      position: 1
  - id: chrom
    type:
      - 'null'
      - string
    doc: optional chromosome to extract depth. default is entire genome.
    inputBinding:
      position: 102
      prefix: --chrom
  - id: directory
    type: Directory
    doc: directory for output files
    inputBinding:
      position: 102
      prefix: --directory
  - id: excludepatt
    type:
      - 'null'
      - string
    doc: exclude patterns for chromosomes
    inputBinding:
      position: 102
      prefix: --excludepatt
  - id: extranormalize
    type:
      - 'null'
      - boolean
    doc: normalize across samples and do local smoothign within sample. this is 
      recommended for CRAI
    inputBinding:
      position: 102
      prefix: --extranormalize
  - id: fai
    type:
      - 'null'
      - File
    doc: fasta index file. Required when crais are used.
    inputBinding:
      position: 102
      prefix: --fai
  - id: includegl
    type:
      - 'null'
      - boolean
    doc: 'plot GL chromosomes like: GL000201.1 which are not plotted by default'
    inputBinding:
      position: 102
      prefix: --includegl
  - id: sex
    type:
      - 'null'
      - string
    doc: comma delimited names of the sex chromosome(s) used to infer sex. Set 
      to '' if no sex chromosomes are present.
    inputBinding:
      position: 102
      prefix: --sex
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/goleft:0.2.6--he881be0_1
stdout: goleft_indexcov.out
