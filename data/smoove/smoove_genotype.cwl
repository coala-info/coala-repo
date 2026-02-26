cwlVersion: v1.2
class: CommandLineTool
baseCommand: smoove
label: smoove_genotype
doc: "Call genotypes for a given set of BAM files.\n\nTool homepage: https://github.com/brentp/smoove"
inputs:
  - id: bams
    type:
      type: array
      items: File
    doc: path to bam to call.
    inputBinding:
      position: 1
  - id: duphold
    type:
      - 'null'
      - boolean
    doc: run duphold on output.
    inputBinding:
      position: 102
      prefix: --duphold
  - id: fasta
    type: File
    doc: fasta file.
    inputBinding:
      position: 102
      prefix: --fasta
  - id: name
    type: string
    doc: project name used in output files.
    inputBinding:
      position: 102
      prefix: --name
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: output directory.
    inputBinding:
      position: 102
      prefix: --outdir
  - id: processes
    type:
      - 'null'
      - int
    doc: number of processors to use.
    default: 3
    inputBinding:
      position: 102
      prefix: --processes
  - id: removepr
    type:
      - 'null'
      - boolean
    doc: remove PRPOS and PREND tags from INFO.
    inputBinding:
      position: 102
      prefix: --removepr
  - id: vcf
    type:
      - 'null'
      - File
    doc: vcf to genotype (use - for stdin).
    default: '-'
    inputBinding:
      position: 102
      prefix: --vcf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smoove:0.2.8--h9ee0642_1
stdout: smoove_genotype.out
