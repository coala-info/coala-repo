cwlVersion: v1.2
class: CommandLineTool
baseCommand: pytrf_findgtr
label: pytrf_findgtr
doc: "Finds tandem repeats in a fasta or fastq file.\n\nTool homepage: https://github.com/lmdu/pytrf"
inputs:
  - id: fastx
    type: File
    doc: input fasta or fastq file (gzip support)
    inputBinding:
      position: 1
  - id: max_motif
    type:
      - 'null'
      - int
    doc: maximum motif length
    inputBinding:
      position: 102
      prefix: --max-motif
  - id: min_length
    type:
      - 'null'
      - int
    doc: minimum repeat length
    inputBinding:
      position: 102
      prefix: --min-length
  - id: min_motif
    type:
      - 'null'
      - int
    doc: minimum motif length
    inputBinding:
      position: 102
      prefix: --min-motif
  - id: min_repeat
    type:
      - 'null'
      - int
    doc: minimum repeat number
    inputBinding:
      position: 102
      prefix: --min-repeat
  - id: out_format
    type:
      - 'null'
      - string
    doc: output format, tsv, csv, bed or gff
    inputBinding:
      position: 102
      prefix: --out-format
  - id: out_file_path
    type: string
    doc: Output or path parameter `out_file_path`
    inputBinding:
      position: 103
      prefix: --out-file
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.out_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pytrf:1.4.2--py310h1fe012e_1
