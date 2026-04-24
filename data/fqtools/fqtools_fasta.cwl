cwlVersion: v1.2
class: CommandLineTool
baseCommand: fqtools_fasta
label: fqtools_fasta
doc: "Convert FASTQ files to FASTA format.\n\nTool homepage: https://github.com/alastair-droop/fqtools"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: The fastq file(s) to view.
    inputBinding:
      position: 1
  - id: length
    type:
      - 'null'
      - int
    doc: Maximum number of sequence characters per line.
    inputBinding:
      position: 102
      prefix: -l
  - id: output_stem
    type:
      - 'null'
      - string
    doc: Output file stem (default "output%").
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fqtools:2.0--h577a1d6_15
stdout: fqtools_fasta.out
