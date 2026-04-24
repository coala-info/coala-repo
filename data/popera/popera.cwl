cwlVersion: v1.2
class: CommandLineTool
baseCommand: popera
label: popera
doc: "DNase I hypersensitive site identification\n\nTool homepage: https://github.com/forrestzhang/Popera"
inputs:
  - id: bandwidth
    type:
      - 'null'
      - int
    doc: kernel smooth band width, should >1
    inputBinding:
      position: 101
      prefix: --bandwidth
  - id: datafile
    type: File
    doc: data file, should be sorted bam format
    inputBinding:
      position: 101
      prefix: --data
  - id: exclude_chr
    type:
      - 'null'
      - string
    doc: Don't count those DHs, example='-x ChrM,ChrC'
    inputBinding:
      position: 101
      prefix: --excludechr
  - id: minlength
    type:
      - 'null'
      - int
    doc: minimum length of hot spots
    inputBinding:
      position: 101
      prefix: --minlength
  - id: output_bigwig
    type:
      - 'null'
      - boolean
    doc: whether out put bigwig file
    inputBinding:
      position: 101
      prefix: --bigwig
  - id: sample_name
    type:
      - 'null'
      - string
    doc: NH sample name
    inputBinding:
      position: 101
      prefix: --name
  - id: threads
    type:
      - 'null'
      - int
    doc: threads number or cpu number
    inputBinding:
      position: 101
      prefix: --threads
  - id: threshold
    type:
      - 'null'
      - float
    doc: Hot spots threshold
    inputBinding:
      position: 101
      prefix: --threshold
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popera:1.0.3--py_0
stdout: popera.out
