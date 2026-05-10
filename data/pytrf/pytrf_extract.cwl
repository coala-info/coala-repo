cwlVersion: v1.2
class: CommandLineTool
baseCommand: pytrf_extract
label: pytrf_extract
doc: "Extracts sequences from fasta or fastq files based on repeat information.\n\n\
  Tool homepage: https://github.com/lmdu/pytrf"
inputs:
  - id: fastx
    type: File
    doc: input fasta or fastq file (gzip support)
    inputBinding:
      position: 1
  - id: flank_length
    type:
      - 'null'
      - int
    doc: flanking sequence length
    inputBinding:
      position: 102
      prefix: --flank-length
  - id: out_format
    type:
      - 'null'
      - string
    doc: output format, tsv, csv or fasta
    inputBinding:
      position: 102
      prefix: --out-format
  - id: repeat_file
    type: File
    doc: the csv or tsv output file of findatr, findstr or findgtr
    inputBinding:
      position: 102
      prefix: --repeat-file
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
