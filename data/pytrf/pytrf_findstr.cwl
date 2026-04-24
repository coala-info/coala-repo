cwlVersion: v1.2
class: CommandLineTool
baseCommand: pytrf_findstr
label: pytrf_findstr
doc: "Finds simple tandem repeats in fasta or fastq files.\n\nTool homepage: https://github.com/lmdu/pytrf"
inputs:
  - id: fastx
    type: File
    doc: input fasta or fastq file (gzip support)
    inputBinding:
      position: 1
  - id: output_format
    type:
      - 'null'
      - string
    doc: output format, tsv, csv, bed or gff
    inputBinding:
      position: 102
      prefix: --out-format
  - id: repeats
    type:
      - 'null'
      - type: array
        items: string
    doc: minimum repeats for each STR type (mono di tri tetra penta hexa)
    inputBinding:
      position: 102
      prefix: --repeats
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pytrf:1.4.2--py310h1fe012e_1
