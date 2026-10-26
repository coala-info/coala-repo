cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - querysketch
label: uniqsketch_querysketch
doc: "Identify references and their abundance in FILE(S).\n\nTool homepage: https://github.com/amazon-science/uniqsketch"
inputs:
  - id: reads_1
    type: File
    doc: input read 1 (fastq, also gz, bz, zip, xz)
    inputBinding:
      position: 101
      prefix: --r1
  - id: reads_2
    type:
      - 'null'
      - File
    doc: input read 2
    inputBinding:
      position: 101
      prefix: --r2
  - id: ref
    type: File
    doc: input uniqsketch reference (the -o output of uniqsketch)
    inputBinding:
      position: 101
      prefix: --ref
  - id: out
    type: string
    doc: the output file name
    inputBinding:
      position: 101
      prefix: --out
  - id: threads
    type:
      - 'null'
      - int
    doc: use N parallel threads [1]
    inputBinding:
      position: 101
      prefix: --threads
  - id: bit
    type:
      - 'null'
      - int
    doc: use N bits per element in Bloom filter [64]
    inputBinding:
      position: 101
      prefix: --bit
  - id: hit
    type:
      - 'null'
      - int
    doc: number of uniqsketch hits to call a reference [10]
    inputBinding:
      position: 101
      prefix: --hit
  - id: acutoff
    type:
      - 'null'
      - float
    doc: abundance cutoff to report [0.0]
    inputBinding:
      position: 101
      prefix: --acutoff
  - id: rcutoff
    type:
      - 'null'
      - int
    doc: read cutoff to report [2]
    inputBinding:
      position: 101
      prefix: --rcutoff
  - id: sensitive
    type:
      - 'null'
      - boolean
    doc: sets sensitivity parameter h=10
    inputBinding:
      position: 101
      prefix: --sensitive
  - id: very_sensitive
    type:
      - 'null'
      - boolean
    doc: sets sensitivity parameter h=5
    inputBinding:
      position: 101
      prefix: --very-sensitive
  - id: solid
    type:
      - 'null'
      - boolean
    doc: only use solid k-mers in reads
    inputBinding:
      position: 101
      prefix: --solid
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: abundance_table
    type: File
    doc: references and their abundance in the sample
    outputBinding:
      glob: $(inputs.out)
  - id: log_files
    type:
      - 'null'
      - type: array
        items: File
    doc: detailed log files (log_ and logread_ files)
    outputBinding:
      glob: log*_$(inputs.out)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/uniqsketch:1.1.0--h077b44d_0
stdout: uniqsketch_querysketch.out
