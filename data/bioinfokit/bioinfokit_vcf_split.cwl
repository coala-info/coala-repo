cwlVersion: v1.2
class: CommandLineTool
baseCommand: split
label: bioinfokit_vcf_split
doc: "Split a file into pieces\n\nTool homepage: https://reneshbedre.github.io/blog/howtoinstall.html"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file to split
    inputBinding:
      position: 1
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files
    inputBinding:
      position: 2
  - id: bytes
    type:
      - 'null'
      - string
    doc: Split by N (kilo|mega)bytes
    inputBinding:
      position: 103
      prefix: -b
  - id: lines
    type:
      - 'null'
      - int
    doc: Split by N lines
    inputBinding:
      position: 103
      prefix: -l
  - id: suffix_length
    type:
      - 'null'
      - int
    doc: Use N letters as suffix
    inputBinding:
      position: 103
      prefix: -a
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioinfokit:2.1.3--pyh7cba7a3_0
stdout: bioinfokit_vcf_split.out
