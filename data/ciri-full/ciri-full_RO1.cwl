cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - CIRI-full
  - RO1
label: ciri-full_RO1
doc: "RO1 identifies 5'-RO features on paired-end RNA-seq reads and merges those RO containing read pairs into long single-end reads\n\nTool homepage: https://ciri-cookbook.readthedocs.io/en/latest/CIRI-full.html"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: reads1
    type: File
    doc: 'reads1 of paired-end reads (required, equal length)'
    inputBinding:
      position: 101
      prefix: '-1'
  - id: reads2
    type: File
    doc: 'reads2 of paired-end reads (required, equal length)'
    inputBinding:
      position: 101
      prefix: '-2'
  - id: prefix
    type:
      - 'null'
      - string
    doc: 'prefix of output files (optional, default: user_dir/out)'
    inputBinding:
      position: 101
      prefix: '-o'
  - id: min_m
    type:
      - 'null'
      - int
    doc: 'sets the number of minimum 5''-RO length (optional, integer, default 13)'
    inputBinding:
      position: 101
      prefix: '-minM'
  - id: min_i
    type:
      - 'null'
      - int
    doc: 'sets the minimum identity percentage of 5''-RO alignment (optional, default 95)'
    inputBinding:
      position: 101
      prefix: '-minI'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_files
    type:
      type: array
      items: File
    doc: 'Files written with the output prefix (prefix_ro1.fq and others)'
    outputBinding:
      glob: $((inputs.prefix || 'out') + '*')
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ciri-full:2.1.2--hdfd78af_1
stdout: ciri-full_RO1.out
