cwlVersion: v1.2
class: CommandLineTool
baseCommand: dmtools index
label: dmtools_index
doc: "Index a genome for dmtools.\n\nTool homepage: https://github.com/ZhouQiangwei/dmtools"
inputs:
  - id: genome_file
    type: File
    doc: genome fasta file
    inputBinding:
      position: 101
      prefix: --genome
  - id: taps
    type:
      - 'null'
      - boolean
    doc: alignment TAPS reads with bwa mem
    inputBinding:
      position: 101
      prefix: --taps
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dmtools:0.2.6--hda3def1_0
stdout: dmtools_index.out
