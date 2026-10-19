cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rainbow
  - div
label: rainbow_div
doc: "Divides clusters into haplotype groups; reads a rainbow cluster table and writes\
  \ the divided table.\n\nTool homepage: https://sourceforge.net/projects/bio-rainbow/"
inputs:
  - id: input_file
    type: File
    doc: Input file (cluster table)
    inputBinding:
      position: 101
      prefix: -i
  - id: output_file
    type:
      - 'null'
      - string
    doc: Output file [stdout]
    inputBinding:
      position: 101
      prefix: -o
  - id: k_allele
    type:
      - 'null'
      - int
    doc: K_allele, min variants to create a new group [2]
    inputBinding:
      position: 101
      prefix: -k
  - id: k_allele_max
    type:
      - 'null'
      - int
    doc: K_allele, divide regardless of frequency when num of variants exceed this
      value [50]
    inputBinding:
      position: 101
      prefix: -K
  - id: min_frequency
    type:
      - 'null'
      - float
    doc: Frequency, min variant frequency to create a new group [0.2]
    inputBinding:
      position: 101
      prefix: -f
outputs:
  - id: stdout
    type: stdout
    doc: Divided cluster table (when -o is not used)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rainbow:2.0.4--pl5321h7b50bb2_11
stdout: rainbow_div.out
