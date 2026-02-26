cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nanopolish
  - vcf2fasta
label: nanopolish_vcf2fasta
doc: "Write a new genome sequence by introducing variants from the input files\n\n\
  Tool homepage: https://github.com/jts/nanopolish"
inputs:
  - id: input_vcfs
    type:
      type: array
      items: File
    doc: VCF files containing variants
    inputBinding:
      position: 1
  - id: fofn
    type:
      - 'null'
      - File
    doc: read the list of VCF files to use from FILE
    inputBinding:
      position: 102
      prefix: --fofn
  - id: genome
    type: File
    doc: the input genome is in FILE
    inputBinding:
      position: 102
      prefix: --genome
  - id: skip_checks
    type:
      - 'null'
      - boolean
    doc: skip the sanity checks
    inputBinding:
      position: 102
      prefix: --skip-checks
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanopolish:0.14.0--h773013f_3
stdout: nanopolish_vcf2fasta.out
