cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfastx_extract
label: pyfastx_extract
doc: "Extract sequences from FASTA/FASTQ files.\n\nTool homepage: https://github.com/lmdu/pyfastx"
inputs:
  - id: fastx
    type: File
    doc: fasta or fastq file, gzip support
    inputBinding:
      position: 1
  - id: names
    type:
      - 'null'
      - type: array
        items: string
    doc: sequence name or read name, multiple names were separated by space
    inputBinding:
      position: 2
  - id: list_file
    type:
      - 'null'
      - File
    doc: a file containing sequence or read names, one name per line
    inputBinding:
      position: 103
      prefix: --list-file
  - id: out_fasta
    type:
      - 'null'
      - boolean
    doc: output fasta format when extract reads from fastq, default output fastq
      format
    inputBinding:
      position: 103
      prefix: --out-fasta
  - id: reverse_complement
    type:
      - 'null'
      - boolean
    doc: output reverse complement sequence
    inputBinding:
      position: 103
      prefix: --reverse-complement
  - id: sequential_read
    type:
      - 'null'
      - boolean
    doc: start sequential reading, particularly suitable for extracting large 
      numbers of sequences
    inputBinding:
      position: 103
      prefix: --sequential-read
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'output file, default: output to stdout'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastx:2.3.0--py312h4711d71_1
